contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]

contacts = {"Joe Smith" => {}}

contacts["Joe Smith"] = contact_data.shift(3)

p contacts