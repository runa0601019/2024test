/* 
	데이터베이스
	데이터베이스란, 우리가 데이터를 규격화하여 저장하는 공간으로써
    우리의 프로그램이 바뀌더라도 데이터베이스 시스템이 남아있으면
    해당 데이터베이스 접속을 하면 기존에 입력한 데이터가 남아있게 된다.
    데이터베이스의 기능을 가장 간략하게 설명하면
    CRUD가 된다.
    C: Create. 데이터의 생성
    R: Retrieve(Read). 데이터의 호출
    U: Update. 데이터의 수정
    D: Delete. 데이터의 삭제
    
    데이터베이스의 구조
    데이터베이스는 컬럼(튜플) -> 로우 -> 테이블 -> 스키마(=데이터베이스) 로 계층이 이루어져있다.
    
*/
	#데이터베이스에서 작업을 하기 전에는 반드시 특정 스키마를 선택을 해주어야 한다.
    #스키마를 선택할 때에는 왼쪽의 SCHEMAS 탭에서
    #사용할 스키마 이름을 더블클릭하거나
    #아니면 USE 스키마이름; 을 입력해주자
    USE sakila;
	#데이터베이스에서 데이터 불러오기
    #SELECT 컬럼이름 FROM 테이블이름
    SELECT actor_id FROM actor;
	#만약 우리가 어떤 특정 컬럼만이 아니라
    #여러 컬럼을 볼 때에는
    #SELECT 컬럼이름, 컬럼이름 FROM 테이블이름
    SELECT actor_id, first_name FROM actor;
    #모든 컬럼을 볼 때에는
    #SELECT * FROM 테이블이름
    SELECT * FROM actor;
	#우리가 필요에 따라서는 조건에 따른 검색이 가능하다.
    #이럴 때에는 SELECT * FROM 테이블이름 WHERE 조건 
    #으로 검색이 가능하다.
    SELECT * FROM actor WHERE actor_id = 20;

	#데이터를 입력할 때에는
    #INSERT INTO 테이블이름 VALUES(값) 으로 입력한다.
    INSERT INTO actor VALUES(1080, 'Jeyung', 'CHO', NOW());
	SELECT * FROM actor WHERE actor_id = 1080;
	
    #만약 우리가 특정 컬럼에만 값을 입력할 때에는
    #INSERT INTO 테이블이름(컬럼이름1, 컬럼이름2...) VALUES(값1, 값2....)
    #으로 입력한다.
    INSERT INTO actor(first_name, last_name) VALUES('철수', '김');
    SELECT * FROM actor WHERE first_name = '철수';

	#우리가 특정 데이터의 값을 수정할 때에는
    #UPDATE 테이블이름 SET 컬럼이름 = 새 값, 컬럼이름 = 새 값... WHERE 특정 조건
    UPDATE actor 
    SET first_name = '재영2',
    last_name = "조",
    last_update = NOW()
    WHERE actor_id = 1080;
    SELECT * FROM actor WHERE actor_id = 1080;

	#로우 삭제하기
    #DELETE FROM 테이블이름 WHERE 삭제조건
    SELECT * FROM actor WHERE actor_id=1081;
    DELETE FROM actor WHERE actor_id=1081;

	#제약 조건
    #제약 조건이란 해당 컬럼에 들어갈 값을 제약하는 특수한 조건들을 뜻한다.
    #PK: Primary Key. 해당 컬럼에 들어갈 값은 "고유"해야하고, "널"이 아니어야 한다.
    #UQ: Unique, 해당 컬럼에 들어갈 값은 “고유”해야 한다.
    #NN: Not NULL, 해당 컬럼에 들어갈 값은 “NULL”이 아니어야 한다.
    
    
    # USER, BOARD 테이블 만들었다면
    
    # 다양한 SQL 쿼리문을 알아보자
    # 1. DISTINCT : 같은 값이 있을 경우, 하나만 보여준다.
    USE world;
    SELECT COUNTRYCODE FROM city;
    SELECT DISTINCT COUNTRYCODE FROM city; # 중복값 뜨지않게 함
    
    # 2. AND : WHERE 조건절에 복합적인 조건을 사용할 때 사용
    SELECT * FROM city;
    # 컨트리코드가 AFG 이고 인구가 1000000 이상인 도시
    SELECT * FROM city WHERE countrycode = 'AFG' AND population >= 1000000;
    
    # 3. OR
    # 컨트리코드가 AFG 혹은 인구가 1000000 이상인 도시
    SELECT * FROM city WHERE countrycode = 'AFG' OR population >= 1000000;
    
    # 4. ORDER BY
    SELECT * FROM city ORDER BY population ASC;
    SELECT * FROM city ORDER BY population DESC;
    
    # 5. NOT
    SELECT * FROM city WHERE NOT countrycode = 'AFG';
    
    # 6. LIMIT
    SELECT * FROM city LIMIT 10; # LIMIT 작성하기 전에는 1000개까지 나옴
    SELECT * FROM city LIMIT 10, 20; # 10번째 줄부터 20개 줄 출력
    
    # 7. MIN()
    SELECT  MIN(population) FROM city;
    
    # 8. MAX()
     SELECT MAX(population) FROM city;
     
     # 9. COUNT()
     SELECT COUNT(name) FROM city; # city의 컬럼 name의 개수 출력
     SELECT COUNT(DISTINCT name) FROM city; # 중복되지 않게 하려면 distinct 추가
     
     # 10. SUM()
     SELECT SUM(population) FROM city;
    
    # 11. AVG()
    SELECT AVG(population) FROM city;
    
    # 12. LIKE : LIKE는 WHERE에서 우리가 특정 값을 적는 것이 아니라, '비슷한' 값을 찾아준다
    SELECT * FROM city
    #WHERE NAME = 'se%';
    WHERE NAME = '%se%';
    
    # 13.
    SELECT * FROM city
	WHERE COUNTRYCODE IN ('KOR', 'BRA', 'JPN');
    
    # 14. 특정 범위의 값을 검색할 때에는 BETWEEN 시작값 AND 끝값 으로 검색
    SELECT * FROM city
    WHERE ID BETWEEN 11 AND 20;
    
    #15. AS
    SELECT ID, NAME as '도시', CountryCode AS '국가' FROM city;
    
    # 16. JOIN
    # 16-a. INNER JOIN, city에서 countrycode를 기준으로 country 테이블을 연결해 출력하라, 해당하는 애들만 묶어서 나오게 됨
    SELECT id, C.name, countrycode, N.name FROM city as C
    INNER JOIN country as N
    ON C.CountryCode = N.code;
    
    # 16-b. LEFT JOIN, city에서 id를 기준으로 country 테이블의 capital을 연결하여 출력하라, 조건에 해당하지 않는 애들은 null값으로 나옴
    # 수도가 아닌 도시들은 NAME, COUNTRYCODE, DISTRICT, POPULATION을 제외한 나머지가 null 값으로 나오게 됨
    SELECT *FROM city
    LEFT JOIN country # INNER JOIN 사용하면 수도인 애들만 나옴
    ON city.id = country.capital;
    
    # 16-c. RIGHT JOIN, 
    SELECT * FROM city
    RIGHT JOIN country
    ON city.id = country.capital;
    
    # 16-d. FULL OUTER JOIN -> 이제 지원안함
    SELECT * FROM city
    FULL JOIN country # 이제 지원하지 않음
    ON city.id = country.capital;
    
    # 17. UNION, 2개 이ㅏㅇ의 SELECT 쿼리 결과를 합쳐서 보고싶을 경우
    SELECT * FROM CITY
    LEFT JOIN country
    ON city.id = country.capital
    UNION
    SELECT * FROM city
    RIGHT JOIN country
    ON city.id = country.capital;
    
    # 18. GROUP BY, 한 컬럼에 여러 값이 중복되어 있을 경우, 한 줄로 묶음처리 하는 것
    SELECT countrycode, sum(population) FROM city # 이제는 *로 묶을 수 없게 하였으므로 하나하나 적어주어야함
    WHERE population >= 30000
    GROUP BY CountryCode;
    
    # 19. SubQuery : IN 조건절에 쿼리를 넣어 해당 쿼리를 만족하는 것들만 다시 뽑아내는 방법, country를 기준으로 보여주기 때문에 inner join보다는 결과가 적게 나옴
    SELECT * FROM country
	WHERE code IN (SELECT countrycode FROM city);
    
    SELECT * FROM country
    WHERE capital IN (SELECT id FROM city);
    
    SELECT * FROM city
    INNER JOIN country ON city.id = country.capital
    WHERE city.population >= 5000000
    ORDER BY city.name DESC;