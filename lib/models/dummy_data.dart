// class DummyData {
//   static final List<String> productImages = [
//     "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe",
//     "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38",
//     "https://images.unsplash.com/photo-1555939594-58d7cb561ad1",
//     "https://images.unsplash.com/photo-1504674900247-0877df9cc836",
//     "https://images.unsplash.com/photo-1525755662778-989d0524087e",
//     "https://images.unsplash.com/photo-1600891964599-f61ba0e24092",
//     "https://images.unsplash.com/photo-1604908554025-e47794f3a8b3",
//     "https://images.unsplash.com/photo-1576402187878-974f70c890a5",
//     "https://images.unsplash.com/photo-1562967916-eb82221dfb33",
//     "https://images.unsplash.com/photo-1605475127972-27c06f1231f4",
//   ];
//   static final Map<String, dynamic> dummyOrderResponseJson = {
//     "type": "order_created",
//     "order": {
//       "id": 101,
//       "user_id": 1,
//       "shift_id": 5,
//       "customer_name": "Ayub Khan",
//       "phone_number": "03001234567",
//       "order_type": "Dine In",
//       "table_number": "T-5",

//       "sub_total": 3500,
//       "tax": 175,
//       "service_charges": 100,
//       "delivery_charges": 0,
//       "sales_discount": 200,
//       "approved_discounts": 100,
//       "promo_discount": 50,
//       "total_amount": 3425,

//       "payment_method": "Cash",
//       "payment_type": "Split",
//       "cash_received": 4000,
//       "change": 575,
//       "cash_amount": 3000,
//       "card_amount": 425,

//       "status": "Completed",
//       "note": "Customer wants quick service",
//       "kitchen_note": "No delay",
//       "order_date": "2025-12-18",
//       "order_time": "13:15",
//       "created_at": "2025-12-18 13:10:00",
//       "updated_at": "2025-12-18 13:20:00",

//       "items": List.generate(
//         10,
//         (i) => {
//           "image": productImages[i],
//           "product_id": i + 1,
//           "title": "Product ${i + 1}",
//           "quantity": (i % 3) + 1,
//           "price": 300 + (i * 50),
//           "unit_price": 300 + (i * 50),
//           "tax_percentage": 5,
//           "tax_amount": 15,
//           "sale_discount_per_item": 10,

//           "note": "Extra spicy",
//           "kitchen_note": "Serve hot",
//           "item_kitchen_note": "No onion",

//           "variant_id": i % 2 == 0 ? 1 : null,
//           "variant_name": i % 2 == 0 ? "Large" : null,

//           "addons": ["Cheese", "Sauce"],
//           "removed_ingredients": ["Onion"],
//         },
//       ),

//       "kot": {
//         "id": 501,
//         "pos_order_type_id": 1,
//         "order_date": "2025-12-18",
//         "order_time": "13:16",
//         "note": "KOT Note",
//         "kitchen_note": "Priority",
//         "created_at": "2025-12-18 13:16:00",
//         "updated_at": "2025-12-18 13:18:00",

//         "items": List.generate(
//           10,
//           (i) => {
//             "id": i + 1,
//             "kitchen_order_id": 501,
//             "item_name": "Product ${i + 1}",
//             "variant_name": i % 2 == 0 ? "Large" : null,
//             "quantity": (i % 3) + 1,
//             "ingredients": ["Chicken", "Spices"],
//             "item_kitchen_note": "Less oil",
//             "status": "Pending",
//             "created_at": "2025-12-18 13:16:00",
//             "updated_at": "2025-12-18 13:18:00",
//           },
//         ),
//       },

//       "promo": [],
//       "applied_promos": [],
//       "approved_discount_details": [],
//       "delivery_location": "Shop #12, Main Market",
//       "auto_print_kot": true,
//     },
//   };
// }
