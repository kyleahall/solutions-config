{
  "branding": {
    "browser_title": "Solutions | A&T ",
    "title": "Solutions - Tax and Appraisals",
    "delimiter": ","
  },
  "tag_list": [
    "Sales",
    "Appeals"
  ],
  "template_entries": [
    {
      "name": "Clermont County Property Data",
      "description": "Tax and Appraisals",
      "dataset_domain": "appraisalandtax.demo.socrata.com",
      "dataset_id": "rf3x-u64k",
      "parent_queries": [
        "select *,:@computed_region_5ynq_aczk,avg(asr) over (partition by land_use_type='commercial') as median_asr, 1-asr/median_asr as asr_deviation_from_median"
      ],
      "fields": {
        "date_column": "saledt",
        "incident_type": "land_use_type",
        "location": "geocoded_column",
        "5ynq-aczk": ":@computed_region_5ynq_aczk"
      },
      "dimension_entries": [
        {
          "column": "land_use_type",
          "name": "Land Use Type"
        },
        {
          "column": "style",
          "name": "Style"
        },
        {
          "column": "taxdist",
          "name": "Tax district"
        },
        {
          "column": "cityname",
          "name": "City"
        }
      ],
      "group_by_entries": [
        {
          "column": "cityname",
          "name": "City"
        },
        {
          "column": "land_use_type",
          "name": "Land Use Type"
        },
        {
          "column": "style",
          "name": "Style"
        },
        {
          "column": "taxdist",
          "name": "Tax district"
        }
      ],
      "view_entries": [
        {
          "name": "Average Sales Ratio",
          "column": "estimated_total_market_value/case(price <= 0 or price is null, case(estimated_total_market_value == 0, 1, true, estimated_total_market_value) , true, price)",
          "aggregate_type": "avg",
          "precision": "2",
          "prefix": "",
          "suffix": "",
          "use_dimension_value": "true",
          "tags": [
            "Sales"
          ],
          "visualization": {   
             "default_view": "Snapshot",
             "snapshot": {
                "chart_type": "groupChart",
                "show_pie_chart": "true"
            }
          }
        },
        {
          "name": "Average Absolute Deviation",
          "column": "asr_deviation_from_median",
          "aggregate_type": "avg",
          "use_dimension_value": "true",
          "precision": "2",
          "prefix": "",
          "suffix": "",
          "tags": [
            "Tax & Appraisals"
          ],
          "visualization": {
             "default_view": "Snapshot",
             "snapshot": {
                "chart_type": "groupChart",
                "show_pie_chart": "true"
            }
          }
        },
        {
          "name": "Coefficient of Dispersion",
          "column": "avg(asr_deviation_from_median)/avg(median_asr)",
          "aggregate_type": "",
          "use_dimension_value": "true",
          "precision": "2",
          "prefix": "",
          "suffix": "",
          "tags": [
            "Sales"
          ],
          "visualization": {
             "default_view": "Snapshot",
             "snapshot": {
                "chart_type": "groupChart",
                "show_pie_chart": "true"
            }
          }
        },
        {
          "name": "Price Relative Differential",
          "column": "avg(asr)/(   sum(estimated_total_market_value)/sum(price)    )",
          "aggregate_type": "",
          "use_dimension_value": "true",
          "precision": "2",
          "prefix": "",
          "suffix": "",
          "tags": [
            "Sales"
          ],
          "visualization": {
             "default_view": "Snapshot",
             "snapshot": {
                "chart_type": "groupChart",
                "show_pie_chart": "true"
            }
          }
        },
        {
          "name": "Median Ratio",
          "column": "estimated_total_market_value/case(price <= 0 or price is null, case(estimated_total_market_value == 0, 1, true, estimated_total_market_value) , true, price)",
          "aggregate_type": "avg",
          "use_dimension_value": "true",
          "precision": "2",
          "prefix": "",
          "suffix": "",
          "tags": [
            "Sales"
          ],
          "visualization": { 
             "default_view": "Snapshot",
             "snapshot": {
                "chart_type": "groupChart",
                "show_pie_chart": "true"
            }
          }
        },
        {
          "name": "Estimated Total Market Value",
          "column": "estimated_total_market_value",
          "aggregate_type": "sum",
          "stack_column": "land_use_type",
          "precision": "0",
          "prefix": "$",
          "suffix": "",
          "tags": [
            "Sales"
          ],
          "visualization": {
             "default_view": "Snapshot",
             "snapshot": {
                "chart_type": "groupChart",
                "show_pie_chart": "true"
            }
          }
        }
      ],
      "filter_by_entries": [
        {
          "column": "style",
          "name": "style"
        }
      ],
      "leaf_page_entries": [
        {
          "column": "address",
          "name": "Address"
        },
        {
          "column": "style",
          "name": "Style"
        },
        {
          "column": "estimated_total_market_value",
          "name": "Estimated Total Market Value"
        },
        {
          "column": "tax_year",
          "name": "Tax Year"
        },
        {
          "name": "Ratio",
          "column": "estimated_total_market_value/case(price <= 0 or price is null, case(estimated_total_market_value == 0, 1, true, estimated_total_market_value) , true, price)"
        }
      ],
      "quick_filter_entries": [
        {
          "column": "style",
          "name": "Style",
          "renderType": "text"
        }
      ],
      "bench_mark_entries": [
        {
          "view_column": "estimated_total_market_value/case(price <= 0 or price is null, case(estimated_total_market_value == 0, 1, true, estimated_total_market_value) , true, price)",
          "display_name": "Ratio Benchmark",
          "value": "1"
        },
        {
          "view_column": "avg(asr)/(   sum(estimated_total_market_value)/sum(price)    )",
          "display_name": "Relative Differential Benchmark",
          "value": "1"
        }
      ],
      "map": {
        "centerLat": "39.018425261608655",
        "centerLng": "-84.00102962486125",
        "zoom": "7",
        "mini_map_zoom": "7",
        "shapes_outline_highlight_width": "4",
        "style_entries": [
          {
            "name": "Street",
            "style": "mapbox://styles/mapbox/streets-v10"
          },
          {
            "name": "Light",
            "style": "mapbox://styles/mapbox/light-v9"
          },
          {
            "name": "Dark",
            "style": "mapbox://styles/mapbox/dark-v9"
          },
          {
            "name": "Satelite",
            "style": "mapbox://styles/mapbox/satellite-v9"
          },
          {
            "name": "Outdoors",
            "style": "mapbox://styles/mapbox/outdoors-v10"
          }
        ]
      },
      "shape_dataset_entries": [
        {
          "shape_dataset_domain": "appraisalandtax.demo.socrata.com",
          "shape_dataset_id": "5ynq-aczk",
          "shape_name": "Clermont Township Boundaries",
          "fields": {
            "shape": "the_geom",
            "shape_id": "_feature_id",
            "shape_name": "townname",
            "shape_description": "label"
          },
          "color": "#32a889"
        }
      ]
    },
    {
      "name": "Appeals",
      "description": "Tax and Appraisals",
      "dataset_domain": "appraisalandtax.demo.socrata.com",
      "dataset_id": "snjj-se4g",
      "parent_queries": [
        
      ],
      "fields": {
        "date_column": "decision_date",
        "incident_type": "own1"
      },
      "dimension_entries": [
        {
          "column": "class",
          "name": "Class"
        },
        {
          "column": "heartyp",
          "name": "Hearing Type"
        },
        {
          "column": "attorney",
          "name": "Attorney"
        },
        {
          "column": "case_status",
          "name": "Case Status"
        },
        {
          "column": "reason_for_appeal",
          "name": "Reason For Appeal"
        }
      ],
      "group_by_entries": [

      ],
      "view_entries": [
        {
          "name": "% Appealed Value Upheld",
          "column": "sum(decision_value) / sum(county_value)",
          "aggregate_type": "",
          "precision": "2",
          "prefix": "",
          "suffix": "%",
          "tags": [
            "Appeals"
          ],
          "visualization": {
             "default_view": "Snapshot",
             "snapshot": {
                "chart_type": "barChart",
                "show_pie_chart": "true"
            }
          }
        }
      ],
      "leaf_page_entries": [
        {
          "column": "heartyp",
          "name": "Hearing Type"
        },
        {
          "column": "attorney",
          "name": "Attorney"
        },
        {
          "column": "case_status",
          "name": "Case Status"
        },
        {
          "column": "reason_for_appeal",
          "name": "Reason For Appeal"
        }
      ],
      "quick_filter_entries": [

      ],
      "bench_mark_entries": [

      ],
      "map": {

      },
      "shape_dataset_entries": [

      ]
    }
  ]
}
