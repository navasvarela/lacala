def seed_dishes(dataset)

  # dataset.insert()
  dataset.insert(:title => "Salmorejo",
  :image_file => "salmorejo.jpg", 
  :short_desc => "(fresh tomatoes, garlic, bread and olive oil). Delicious in a little bowl sprinkled with egg and Iberico ham",
  :text => "Salmorejo is from Cordoba. Similar to Gazpacho. It is served as a starter or first meal and must obvoiusly be chilled before eating. It's accompanied with las guarniciones: little chunks of jamon serrano, crumbled hard boiled egg or tuna flakes better if it's of the bonito kind with finely sliced fresh onion and green pepper. Less known abroad, Salmorejo is found in any house in Andalucia, restaurant and tapas bar. In the tapas bar it is used as a sauce for preparing montadidos, tiny sandwhiches filled with various ingredients, the most typical being jamon serrano.")
  dataset.insert(:title => "Flamenquines",
  :image_file => "flamenquin.jpg", 
  :short_desc => "(Pork loin, stuffed with Serrano ham). This dish is from Cordoba in Andalucia)",
  :text => "Flamenquin is a delicious meat dish originally from Cordoba. It is made of tenderised pork loin rolled together with a slice of jamon serrano. The roll is covered with egg, flour and breadcrumbs and deep fried.")
end
