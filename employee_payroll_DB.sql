# UC-1-create payroll service database.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
6 rows in set (0.01 sec)

mysql> USE payroll_service;
mysql> CREATE DATABASE payroll_service;
Query OK, 1 row affected (0.02 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| payroll_service    |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.00 sec)

mysql> USE payroll_service;
Database changed
mysql> SELECT DATABASE();
+-----------------+
| DATABASE()      |
+-----------------+
| payroll_service |
+-----------------+
1 row in set (0.00 sec)


# UC-2-CreateEmployeePayrollDatabase

mysql> CREATE TABLE employee_payroll
    -> (
    -> id               INT unsigned NOT NULL AUTO_INCREMENT,
    -> name             VARCHAR(150) NOT NULL,
    -> salary           Double NOT NULL,
    -> start            DATE NOT NULL,
    -> PRIMARY KEY      (id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> DESCRIBE employee_payroll;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int unsigned | NO   | PRI | NULL    | auto_increment |
| name   | varchar(150) | NO   |     | NULL    |                |
| salary | double       | NO   |     | NULL    |                |
| start  | date         | NO   |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
4 rows in set (0.01 sec)

# UC-3-Insert data into employee_payroll database

mysql> INSERT INTO employee_payroll ( name, salary, start) VALUES
    -> ( 'Bill', 1000000.00, '2018-01-03' ),
    -> ( 'Terisa', 2000000.00, '2019-11-13' ),
    -> ( 'Charlie', 3000000.00, '2020-05-21' );
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

# UC-4-Retrieve employee_payroll data

mysql> SELECT * FROM employee_payroll;
+----+---------+---------+------------+
| id | name    | salary  | start      |
+----+---------+---------+------------+
|  1 | Bill    | 1000000 | 2018-01-03 |
|  2 | Terisa  | 2000000 | 2019-11-13 |
|  3 | Charlie | 3000000 | 2020-05-21 |
+----+---------+---------+------------+
3 rows in set (0.01 sec)

# UC-5-Retrieve salary data for perticular name as well as the given date range


mysql> SELECT * FROM employee_payroll
    -> WHERE start BETWEEN CAST('2019-01-01' AS DATE) AND DATE(NOW());
+----+---------+---------+------------+
| id | name    | salary  | start      |
+----+---------+---------+------------+
|  2 | Terisa  | 2000000 | 2019-11-13 |
|  3 | Charlie | 3000000 | 2020-05-21 |
+----+---------+---------+------------+
2 rows in set (0.01 sec)

mysql> SELECT salary FROM employee_payroll WHERE name = "Bill";
+---------+
| salary  |
+---------+
| 1000000 |
+---------+
1 row in set (0.01 sec)

# UC-6-update gender of the employee_payroll data.

mysql> pdate employee_payroll set gender = 'M' WHERE name = 'Bill' or name = 'Charlie';
Query OK, 2 rows affected (0.03 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> SELECT *FROM employee_payroll;
+----+---------+--------+---------+------------+
| id | name    | gender | salary  | start      |
+----+---------+--------+---------+------------+
|  1 | Bill    | M      | 1000000 | 2018-01-03 |
|  2 | Terisa  | F      | 2000000 | 2019-11-13 |
|  3 | Charlie | M      | 3000000 | 2020-05-21 |
+----+---------+--------+---------+------------+
3 rows in set (0.01 sec)

# UC-7-find min max avg and number of male and female employee.

mysql> SELECT AVG(basic_pay) FROM employee_payroll WHERE gender = 'M' GROUP BY gender;
+----------------+
| AVG(basic_pay) |
+----------------+
|        2000000 |
+----------------+
1 row in set (0.01 sec)

mysql> SELECT AVG(basic_pay) FROM employee_payroll GROUP BY gender;
+----------------+
| AVG(basic_pay) |
+----------------+
|        2000000 |
|        3000000 |
+----------------+
2 rows in set (0.00 sec)

mysql> SELECT gender, AVG(basic_pay) FROM employee_payroll GROUP BY gender;
+--------+----------------+
| gender | AVG(basic_pay) |
+--------+----------------+
| M      |        2000000 |
| F      |        3000000 |
+--------+----------------+
2 rows in set (0.00 sec)

mysql> SELECT gender, COUNT(name) FROM employee_payroll GROUP BY gender;
+--------+-------------+
| gender | COUNT(name) |
+--------+-------------+
| M      |           2 |
| F      |           1 |
+--------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT gender, SUM(basic_pay) FROM employee_payroll GROUP BY gender;
+--------+----------------+
| gender | SUM(basic_pay) |
+--------+----------------+
| M      |        4000000 |
| F      |        3000000 |
+--------+----------------+
2 rows in set (0.00 sec)

mysql> SELECT gender, MAX(basic_pay) FROM employee_payroll GROUP BY gender;
+--------+----------------+
| gender | MAX(basic_pay) |
+--------+----------------+
| M      |        3000000 |
| F      |        3000000 |
+--------+----------------+
2 rows in set (0.01 sec)

mysql> SELECT gender, MIN(basic_pay) FROM employee_payroll GROUP BY gender;
+--------+----------------+
| gender | MIN(basic_pay) |
+--------+----------------+
| M      |        1000000 |
| F      |        3000000 |
+--------+----------------+
2 rows in set (0.00 sec)

# UC-8-add phone number, address, department.

mysql> DESCRIBE employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int unsigned | NO   | PRI | NULL    | auto_increment |
| name         | varchar(150) | NO   |     | NULL    |                |
| department   | varchar(250) | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | PUNE    |                |
| phone_number | varchar(250) | YES  |     | NULL    |                |
| gender       | char(1)      | YES  |     | NULL    |                |
| basic_pay    | double       | NO   |     | NULL    |                |
| deductions   | double       | NO   |     | NULL    |                |
| taxable_pay  | double       | NO   |     | NULL    |                |
| tax          | double       | NO   |     | NULL    |                |
| net_pay      | double       | NO   |     | NULL    |                |
| start        | date         | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
12 rows in set (0.01 sec)