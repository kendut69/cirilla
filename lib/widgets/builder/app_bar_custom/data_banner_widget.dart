Map<String, dynamic> dataBannerWidget = {
  "id": "banner_1734597955400_fxq0yk1",
  "type": "banner-custom",
  "fields": {
    "size": {"width": "20", "height": "20"},
    "enableScaleWidth": true,
    "items": [
      {
        "template": "style9",
        "data": {
          "image": {
            "src":
                "https://shop.bsvtech.com.my/wp-content/uploads/2024/12/clock.png"
          },
          "imageSize": "cover",
          "text1": {
            "text": "All Products",
            "style": {
              "color": {
                "value": {"r": 0, "g": 0, "b": 0, "a": 1},
                "dark": {"r": 255, "g": 255, "b": 255, "a": 1}
              },
              "fontSize": 10,
              "fontWeight": "500"
            }
          },
          "radiusImage": 8,
          "enableRoundImage": true,
          "action": {
            "type": "screen",
            "route": "/product_list",
            "args": {"key": "screens_products"}
          }
        }
      },
      {
        "template": "style9",
        "data": {
          "image": {
            "src":
                "https://shop.bsvtech.com.my/wp-content/uploads/2024/12/gift.png"
          },
          "imageSize": "cover",
          "text1": {
            "text": "Rewards",
            "style": {
              "color": {
                "value": {"r": 0, "g": 0, "b": 0, "a": 1},
                "dark": {"r": 255, "g": 255, "b": 255, "a": 1}
              },
              "fontSize": 10,
              "fontWeight": "500"
            }
          },
          "radiusImage": 8,
          "enableRoundImage": true,
          "action": {
            "type": "screen",
            "route": "/profile/pointAndReward",
            "args": {"key": "pointAndReward"}
          }
        }
      },
      {
        "template": "style9",
        "data": {
          "image": {
            "src":
                "https://shop.bsvtech.com.my/wp-content/uploads/2024/12/checklist.png"
          },
          "imageSize": "cover",
          "text1": {
            "text": "View Orders",
            "style": {
              "color": {
                "value": {"r": 0, "g": 0, "b": 0, "a": 1},
                "dark": {"r": 255, "g": 255, "b": 255, "a": 1}
              },
              "fontSize": 10,
              "fontWeight": "500"
            }
          },
          "radiusImage": 8,
          "enableRoundImage": true,
          "action": {
            "type": "screen",
            "route": "/order_list",
            "args": {"key": "screens_none"}
          }
        }
      },
      {
        "template": "style9",
        "data": {
          "image": {
            "src":
                "https://shop.bsvtech.com.my/wp-content/uploads/2024/12/live-chat.png"
          },
          "imageSize": "cover",
          "text1": {
            "text": "Live Chat",
            "style": {
              "color": {
                "value": {"r": 0, "g": 0, "b": 0, "a": 1},
                "dark": {"r": 255, "g": 255, "b": 255, "a": 1}
              },
              "fontSize": 10,
              "fontWeight": "500"
            }
          },
          "radiusImage": 8,
          "enableRoundImage": true,
          "action": {
            "type": "screen",
            "route": "/intercom",
            "args": {"key": "screens_none"}
          }
        }
      }
    ]
  },
  "layout": "grid",
  "styles": {
    "padding": {
      "paddingLeft": 12,
      "paddingRight": 12,
      "paddingBottom": 10,
      "paddingTop": 10
    },
    "margin": {
      "marginLeft": 0,
      "marginRight": 0,
      "marginBottom": 0,
      "marginTop": 0
    },
    "background": {
      "value": {"r": 255, "g": 255, "b": 255, "a": 1},
      "dark": {"r": 49, "g": 49, "b": 49, "a": 1}
    },
    "backgroundImage": {"src": ""},
    "pad": 12,
    "height": 200,
    "col": "4",
    "ratio": "0.65",
    "indicatorColor": {
      "value": {"r": 222, "g": 226, "b": 230, "a": 1},
      "dark": {"r": 142, "g": 142, "b": 147, "a": 1}
    },
    "indicatorActiveColor": {
      "value": {"r": 159, "g": 173, "b": 192, "a": 1},
      "dark": {"r": 255, "g": 255, "b": 255, "a": 1}
    },
    "__line": "",
    "__header": "",
    "backgroundColorItem": {
      "dark": {"r": 0, "g": 0, "b": 0, "a": 0},
      "value": {"r": 0, "g": 0, "b": 0, "a": 0}
    },
    "radius": 8.0,
    "shadowColor": {
      "value": {"r": 155, "g": 155, "b": 155, "a": 1},
      "dark": {"r": 255, "g": 255, "b": 255, "a": 0}
    },
    "offsetX": 0,
    "offsetY": 3,
    "blurRadius": 8,
    "spreadRadius": 0
  },
  "disable": false
};

Map<String, dynamic> dataTextWidget = {
  "id": "text_1734689321035_hv82dj",
  "type": "text",
  "fields": {
    "title": {
      "text": "Good Day,",
      "style": {
        "color": {
          "value": {"r": 244, "g": 244, "b": 244, "a": 1},
          "dark": {"r": 49, "g": 49, "b": 49, "a": 1}
        },
        "fontSize": 10,
        "fontFamily": "Poppins",
        "fontWeight": "600"
      }
    },
    "alignment": "left",
    "action": {
      "type": "screen",
      "route": "none",
      "args": {"key": "screens_none"}
    }
  },
  "styles": {
    "padding": {
      "paddingLeft": 0,
      "paddingRight": 0,
      "paddingBottom": 0,
      "paddingTop": 0
    },
    "margin": {
      "marginLeft": 0,
      "marginRight": 0,
      "marginBottom": 0,
      "marginTop": 0
    },
    "background": {
      "value": {"r": 244, "g": 244, "b": 244, "a": 0},
      "dark": {"r": 49, "g": 49, "b": 49, "a": 0}
    }
  },
  "disable": false
};

// Map<String, dynamic> dataTextRewardWidget = {
//   "id": "text_1734689321035_hv82dj",
//   "type": "text",
//   "fields": {
//     "title": {
//       "text": "Reward: 9500 Pints >",
//       "style": {
//         "color": {
//           "value": {"r": 244, "g": 244, "b": 244, "a": 1},
//           "dark": {"r": 49, "g": 49, "b": 49, "a": 1}
//         },
//         "fontSize": 10,
//         "fontFamily": "Poppins",
//         "fontWeight": "600"
//       }
//     },
//     "alignment": "left",
//     "action": {
//       "type": "screen",
//       "route": "/order_list",
//       "args": {"key": "screens_none"}
//     }
//   },
//   "styles": {
//     "padding": {
//       "paddingLeft": 0,
//       "paddingRight": 0,
//       "paddingBottom": 0,
//       "paddingTop": 0
//     },
//     "margin": {
//       "marginLeft": 0,
//       "marginRight": 0,
//       "marginBottom": 0,
//       "marginTop": 0
//     },
//     "background": {
//       "value": {"r": 244, "g": 244, "b": 244, "a": 0},
//       "dark": {"r": 49, "g": 49, "b": 49, "a": 0}
//     }
//   },
//   "disable": false
// };
