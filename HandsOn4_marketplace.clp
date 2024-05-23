(deftemplate accessories
  (slot type) 
  (slot material) 
  (slot price))

(deftemplate computer 
  (slot brand) 
  (slot model) 
  (slot price) 
  (slot ram))

(deftemplate smartphones
  (slot brand) 
  (slot model) 
  (slot price) 
  (slot ram))

(deftemplate customers 
  (slot id) 
  (slot name) 
  (slot type)
  (slot gender))

(deftemplate credit_card 
  (slot bank) 
  (slot group) 
  (slot date-expiration))

(deftemplate vouchers
   (slot value))

(deftemplate purchases
  (slot id) 
  (multislot items)
  (slot purchase_history)
  (slot count)
)

(deffacts accessories_list
  (accessories (type "Funda para laptop")(material "Cuero")(price 49.99))
  (accessories (type "Cargador inalámbrico")(material "Plástico")(price 29.99))
  (accessories (type "Auriculares Bluetooth")(material "Metal y Plástico")(price 79.99)))

(deffacts computer_list
  (computer (brand "Lenovo")(model "ThinkPad X1 Carbon")(price 1599)(ram 16))
  (computer (brand "Asus")(model "ZenBook 14")(price 1099)(ram 8))
  (computer (brand "Apple")(model "MacBook Air")(price 999)(ram 8)))

(deffacts smartphones_list
  (smartphones (brand "xiaomi")(model "Redmi")(price 4200)(ram 6))
  (smartphones (brand "Samsung")(model "Galaxy S20")(price 8999)(ram 8))
  (smartphones (brand "Apple")(model "iPhone 13")(price 10999)(ram 6)))

(deffacts customers_list
  (customers (id 1)(name "Ana")(type "Premium")(gender "Female"))
  (customers (id 2)(name "Oswaldo")(type "Regular")(gender "Male"))
  (customers (id 3)(name "Dulce")(type "VIP")(gender "Female")))

(deffacts credit_card_list
  (credit_card (bank "Visa")(group "Gold")(date-expiration "2026-08"))
  (credit_card (bank "Mastercard")(group "Silver")(date-expiration "2025-12"))
  (credit_card (bank "American Express")(group "Platinum")(date-expiration "2027-03")))

(deffacts voucher_list
   (vouchers (value 100))
   (vouchers (value 200))
   (vouchers (value 50))
)

(deffacts purchases_list
  (purchases 
    (id 1)
    (items computer "Lenovo" "ThinkPad X1 Carbon" price 1599 ram 16)
    (purchase_history "2024")
    (count 5))
(purchases 
    (id 2)
    (items smartphones "Samsung" "Galaxy S20" price 8999 ram 8)
    (purchase_history "2020")
    (count 30))
(purchases 
    (id 1)
    (items accessories "Funda para laptop" "Cuero" 49.99)
    (purchase_history "2024")
    (count 2))
(purchases 
    (id 3)
    (items smartphones "Apple" "iPhone 13" 10999 ram 6)
    (purchase_history "2023")
    (count 10))
)
  

;RULES

(defrule wholesaler-ten
    (purchases (id ?id) (count ?count&:(> ?count 9)))
    (customers (id ?id) (name ?name))
    (bought ?name)
    (not (is-wholesaler ?name))
    =>
    (printout t "Customer " ?name " is a wholesaler for purchasing more than 10 products multiple times." crlf)
    (assert (is-wholesaler ?name))
)

(defrule retailer-five
    (purchases (id ?id) (count ?count&:(> ?count 4)))
    (customers (id ?id) (name ?name))
    (bought ?name)
    (not (is-retailer ?name))
    =>
    (printout t "Customer " ?name " is a retailer for purchasing less than 5 products multiple times." crlf)
    (assert (is-retailer ?name))
)

(defrule clients-three
    (purchases (id ?id) (count ?count&:(< ?count 3)))
    (customers (id ?id) (name ?name))
    (bought ?name)
    (not (is-clients ?name))
    =>
    (printout t "Customer " ?name " continue shopping." crlf)
    (assert (is-clients ?name))
)


(defrule purchases-2024
    (purchases (id ?id) (purchase_history "2024"))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " made a purchase in 2024." crlf)
)

(defrule purchases-before-2020
    (purchases (id ?id) (purchase_history ?date&:(< ?date "2020")))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " made a purchase before 2020." crlf)
)

(defrule high-ram-computers
    (purchases (id ?id) (items computer ?brand ?model price ?price ram 16))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " purchased a computer with 16GB of RAM." crlf)
)

(defrule gold-credit-card
    (purchases (id ?id))
    (credit_card (group "Gold"))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " made a purchase using a Gold credit card." crlf)
)

(defrule voucher-200
    (purchases (id ?id) (items ?type ?brand ?model ?price) (count ?count))
    (vouchers (value 200))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " used a $200 voucher." crlf)
)

(defrule low-price-purchases
    (purchases (id ?id) (items ?type ?brand ?model price ?price&:(< ?price 50)))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " made low-price purchases." crlf)
)

(defrule eight-gb-ram-smartphones
    (purchases (id ?id) (items smartphones ?brand ?model price ?price ram 8))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " purchased a smartphone with 8GB of RAM." crlf)
)

(defrule expensive-purchases
    (purchases (id ?id) (items ?type ?brand ?model price ?price&:(> ?price 10000)))
    (customers (id ?id) (name ?name))
    =>
    (printout t "Customer " ?name " made expensive purchases." crlf)
)
