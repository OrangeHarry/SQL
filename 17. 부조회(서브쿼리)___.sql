
-----------
부조회(서브쿼리, INNER QUERY)
: 쿼리 안에 있는 또 다른 쿼리
________________________
서브쿼리를 사용하는 경우
:구절의 순서를 바꿔야 하는 경우
 먼저 수행해서 결과를 남겨야 하는 경우

SELECT 
FROM 
WHERE 
GROUP BY 
HAVING 
ORDER BY 

SELECT * 
FROM city         
where population = (select max(population) from city);
_______________




        NOTICE 테이블에서 최신 등록순으로 정렬한 결과에서 
        상위 10개의 게시글을 원하는 경우라면?

        
        SELECT WRITER_ID, TITLE, REGDATE,
            DENSE_RANK() OVER(ORDER BY REGDATE DESC) `NO`
        FROM NOTICE
        WHERE `NO` BETWEEN 1 AND 10;
        -- 오류발생!


        SELECT A.WRITER_ID, A.TITLE, A.REGDATE, A.`NO`
        FROM   A
        WHERE  A.`NO` BETWEEN 1 AND 10;


        SELECT WRITER_ID, TITLE, REGDATE, 
            DENSE_RANK() OVER(ORDER BY REGDATE DESC) `NO`
        FROM NOTICE;


        SELECT A.WRITER_ID, A.TITLE, A.REGDATE, A.`NO`
        FROM   
            (
                SELECT WRITER_ID, TITLE, REGDATE, 
                    DENSE_RANK() OVER(ORDER BY REGDATE DESC) `NO`
                FROM NOTICE
            ) A
        WHERE  A.`NO` BETWEEN 1 AND 10;

        --서브쿼리(select구절)를 먼저 실행시키게 하기 위해서 ()로 묶어준거지


    > IDOL_MEMBER 테이블에서 나이가 27세 이상인 멤버를 조회하시오
        ----------------------------------------------------
         SELECT GROUP_NAME, MEMBER_NAME, YEAR(NOW())-YEAR(BIRTHDAY)+1 AGE
         FROM IDOL_MEMBER
         WHERE AGE >= 27;
         -- ERROR 1054 (42S22): Unknown column 'AGE' in 'where clause'   

         SELECT GROUP_NAME, MEMBER_NAME, AGE
         from ( 
                select GROUP_NAME, MEMBER_NAME,YEAR(NOW())-YEAR(BIRTHDAY)+1 `AGE`
                from idol_member
             ) idol_member
             where age >= 27;

        SELECT GROUP_NAME, MEMBER_NAME, YEAR(NOW())-YEAR(BIRTHDAY)+1 AGE
        from idol_member
        HAVING age >= 27;




        ----------------------------------------------------


    > IDOL_MEMBER 테이블에서 평균 나이 이상인 멤버를 조회하시오;
        ----------------------------------------------------
        SELECT *
        FROM (
               SELECT *,YEAR(NOW())-YEAR(BIRTHDAY)+1 `AGE`
               FROM IDOL_MEMBER
        )IDOL_MEMBER
        WHERE AGE >= (SELECT ROUND(AVG(YEAR(NOW())-YEAR(BIRTHDAY)+1))
                      FROM IDOL_MEMBER) ORDER BY AGE DESC;

        SELECT *,YEAR(NOW())-YEAR(BIRTHDAY)+1 `AGE`
        FROM IDOL_MEMBER
        HAVING AGE >= (
                        SELECT ROUND(AVG(YEAR(NOW())-YEAR(BIRTHDAY)+1))
                        FROM IDOL_MEMBER
                      );

        --WITH 절을 사용하여 가상테이블 생성
        WITH TBL AS
        (
         SELECT *,YEAR(NOW())-YEAR(BIRTHDAY)+1 `AGE`
         FROM IDOL_MEMBER 
        )

        SELECT GROUP_NAME, MEMBER_NAME, AGE
        FROM TBL
        WHERE AGE >= (SELECT AVG(TBL.AGE)FROM TBL);

        --()안에 여러개를 넣고 싶을때 앞에 IN을 써주면 
        --단일값이 아닌 목록을 넣을 수 있다.
        ----------------------------------------------------


-- 위치에 따라 사용되는 서브쿼리

1. SELECT 절에서 사용되는 서브쿼리(Scalar Subquery)
  : 하나의 레코드에 하나의 값을 리턴하는 서브쿼리 --단일컬럼만 가능하다
    컬럼값이 오는 모든 자리에 사용

    > NOTICE TALBE로부터 작성자(sjpark)의 게시글 HIT 평균값
      과 HIT 수를 출력하시오 ;
        ----------------------------------------------------
        SELECT TITLE, WRITER_ID, HIT, 
               (
                 SELECT AVG(HIT) FROM NOTICE
                 WHERE WRITER_ID = 'sjpark'
               )AS AVG_HIT
        FROM NOTICE
        WHERE WRITER_ID = 'sjpark';

        ----------------------------------------------------

    > CITY 정보를 조회(단, 해당 도시의 나라이름 포함)하시오;
        ----------------------------------------------------
        SELECT A.NAME, A.COUNTRYCODE, 
                (
                  SELECT B.NAME
                  FROM country B
                  WHERE A.COUNTRYCODE = CODE 
                )AS CONTRY_NAME, A.POPULATION
        FROM CITY A;       

        ----------------------------------------------------

        
2. FROM 절에서 사용되는 서브쿼리(Inline View)

     > NOTICE TALBE로부터 작성자(sjpark)의 게시글 HIT수가 15 이상인
       게시글들을 출력하시오 ;
        ----------------------------------------------------
        SELECT ID, WRITER_ID, HIT
        FROM NOTICE
        WHERE WRITER_ID = 'sjpark'
        AND HIT >= 15;

        SELECT TITLE, WRITER_ID, HIT
        FROM (
              SELECT *
              FROM NOTICE
              WHERE WRITER_ID = 'sjpark') X
        WHERE X.HIT >= 15
        ORDER BY HIT DESC;

        SELECT TITLE, WRITER_ID, HIT
        FROM (
              SELECT *
              FROM NOTICE
              WHERE WRITER_ID = 'sjpark' AND HIT >=15) NOTICE
        ORDER BY HIT DESC;
      
        ----------------------------------------------------




3. WHERE 절에서 사용되는 서브쿼리(중첩서브쿼리)

    -- 서브쿼리 결과에 따라

    - 단일행 서브쿼리
      서브쿼리의 결과가 1개의 행만 나오는 것
      단일행 서브쿼리 연산자 : =, <, >, <>

    - 다중행 서브쿼리(Multiple-Row Subquery)
      서브쿼리의 결과가 2건 이상 출력되는 경우
      다중행 서브쿼리 연산자 : IN


    > NOTICE TALBE로부터 가입인사 관련 게시글 중 HIT 수가
      100 이상인 게시글의 작성자와 TITLE, HIT 수를 조회하시오;
        ----------------------------------------------------
        SELECT TITLE, WRITER_ID, HIT
        FROM NOTICE
        WHERE TITLE LIKE '%가입인사%' AND HIT >= 100;

        SELECT TITLE, WRITER_ID, HIT
        FROM NOTICE
        WHERE WRITER_ID IN
        (
          SELECT WRITER_ID FROM NOTICE
          WHERE TITLE LIKE '%가입인사%' AND HIT >= 100
        );

        ----------------------------------------------------


    > EMPLOYEES 테이블에서 개발부서(Development) 소속인 직원들을 조회하시오;
        ----------------------------------------------------
        SELECT * FROM EMPLOYEES LIMIT 5;
        SELECT * FROM DEPT_EMP LIMIT 5;
        SELECT * FROM DEPARTMENTS;

        SELECT *
        FROM EMPLOYEES A
        WHERE A.EMP_NO IN
        (
          SELECT B.EMP_NO, 
          FROM DEPT_EMP B
          WHERE B.DEPT_NO = 'd005'
        )
        LIMIT 100;
        --안된다 파일질라에서 파일 받아서 확인해보자

        ---------------------------------------------------- 


    > CITY 테이블에서 인구가 가장 많은 도시의 정보를 조회하시오;
        ----------------------------------------------------
        SELECT MAX(POPULATION) FROM CITY;

        SELECT *
        FROM CITY A
        WHERE A.POPULATION = 
        (
         SELECT MAX(POPULATION) FROM CITY
        );
        ----------------------------------------------------         