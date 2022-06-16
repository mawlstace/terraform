adding variable in main db module in main.tf 

DB_name = ["mysql","mariadb","dynamodb"] 
passing this variable as a list 
created the variable in DB module 
then use count length in main.tf of DB module 

output i used * to print them all but i could use from o to 2 as they are list having 3 values 

