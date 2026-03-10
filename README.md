# assix-bbddoe

docker run --name oussama -p3307:3306 -e MYSQL_ROOT_PASSWORD=1234 -d mysql:latest

docker run --name my-phpmyadmin -d --link oussama:db -p 8080:80 phpmyadmin/phpmyadmin

installamos los plugins en en el icono de la cajita

en el apartado de puertos abjo en l terminal tenemos para acceder al php my admin

instalamos el pluig de mysql tools de maria db mysql i tidb

instalamos el mysql tools
conectamos a la base de datos i vamos haciendo pruebas
