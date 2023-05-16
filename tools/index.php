<?php
		$host = "mariadb" ;
                $username = "test_user" ;
                $password = "secretpass" ;
                $sqldb = "firstdb" ;
                $aza = mysqli_connect($host, $username, $password, $sqldb) ;


                $query2 = "CREATE TABLE membersList (
                        userIds INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        userName VARCHAR(64),
                        pass VARCHAR(64),
                        email VARCHAR(64),
                        phone VARCHAR(64),
                        wallet VARCHAR(128),
                        memKey VARCHAR(64),
                        country VARCHAR(64),
                        vipLevel INT UNSIGNED,
                        tmp     VARCHAR(64),
                       regDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE C>
                        INDEX(userName )
                )";
                 mysqli_query($aza, $query2);

                echo "done";
?>


