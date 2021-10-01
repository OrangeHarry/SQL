
--------------
함수()의 필요성

테이블 데이터는 구조적인 틀안에 격자형으로 표현된다.
이 구조에서는 ROW만 또는 COLUMN만 필터링 가능하다.

이름은 몇 자인가? 
성은 제외하고 이름만 어떻게 되는가?
이름에 빈 공백을 제거하고 출력하려면?
.... ?
________________________________________________





1. 문자열 함수

   ■ SUBSTR('문자열', 시작위치, 길이)
        ----------------------------------------------------
--    db에서는 인덱스 번호가 0번이 아닌 1번부터 시작한다.
        SELECT  substr('HELLO', 1, 3);
        SELECT  substr('HELLO', 3);

        SELECT  substr(GROUP_NAME, 2) 
        FROM idol_member;
        ---------------------------------------------------

    > 모든 아이돌멤버의 이름과 출생 월만 조회하시오
        ---------------------------------------------------
       select member_name, substr(birthday, 5,2) birthday_month
       -> from idol_member;
        ---------------------------------------------------

    > 아이돌그룹 중 'JYP'로 시작하는 모든 그룹정보를 출력하시오
        ----------------------------------------------------
       select * from idol_group
       -> where substr(company, 1,3) = 'JYP';

       select * from idol_group
       -> where company like 'JYP%';

       select * from idol_group
       -> where company regexp('^JYP');
        ----------------------------------------------------

    > 모든 아이돌멤버의 나이를 출력하시오
        ----------------------------------------------------
       select member_name, 2022 - substr(birthday, 1,4) AGE
       -> from idol_member;

       select member_name, YEAR(sysdate()) - substr(birthday, 1,4)+1 AGE
       ->  from idol_member;

       select member_name, substr(NOW(),1,4) - substr(birthday, 1,4)+1 AGE
       ->  from idol_member;
        ----------------------------------------------------    

   ■ CONCAT()    문자열 이어주기
     CONCAT_WS() 구분자와 함께 문자열 이어주기
        ----------------------------------------------------
        SELECT CONCAT('My', 'S', 'QL', ' JAVA211');
        SELECT CONCAT('A', "B", "CDE", 'F');
        SELECT CONCAT('A', "B", NULL, 'F');  --얘는 그냥 NULL이다.
        SELECT CONCAT_WS('-','2021','01','20'); -- 2021-01-20
        ----------------------------------------------------

    > 모든 아이돌그룹에 대하여 'BTS♥boys'의 형식과 같이 출력하시오
        ----------------------------------------------------
        select concat(group_name,'♥', gender, 's') group_name♥gender
        -> from idol_group;

        -- select group_name, concat(group_name,'♥', gender 's')
        -- -> from idol_group;
        ----------------------------------------------------

   ■ TRIM() 문자열 공백제거 함수
       ----------------------------------------------------
        SELECT      '         Hello                     '  result1;
        SELECT trim('         Hello                     ') result2;
       ----------------------------------------------------

   ■ LOWER() / UPPER()
       ----------------------------------------------------
        SELECT lower('HELLO');
        SELECT upper('WOrlD');
       ----------------------------------------------------   

   ■ REPLACE('문자열', '찾는 문자열', '대치할 문자열')
       ----------------------------------------------------
        SELECT replace('HELLO WORLD', 'HELLO', 'HI~') AS RESULT;
       ----------------------------------------------------      

    > 아이돌 그룹에서 회사명 '~ 엔터테인먼트'를 '~ ENTERTAINMENT'로
      출력하시오
       ----------------------------------------------------
        select replace(company, '엔터테인먼트', 'ENTERTAINMENT') company
        -> from idol_group;
       ----------------------------------------------------

   ■ 문자열 패딩 함수() LPAD()/RPAD() 
       ----------------------------------------------------
        SELECT lpad('12345', 10, '0') AS RESULT; --글자 수 10개로 만들기 나머지는 0으로 채움 앞에서부터 (leftpad)
        SELECT rpad('12345', 10, '0') AS RESULT; --글자 수 10개로 만들기 나머지는 0으로 채움 뒤에서부터 (rightpad)
        SELECT LPAD('AB',4,'CD') AS RESULT;
        SELECT RPAD('AB',4,'CD') AS RESULT;
       ----------------------------------------------------   

   ■ INSTR(문자열, 검색문자열) 위치 반환
        ----------------------------------------------------
         SELECT INSTR('foobarbar', 'bar');
         SELECT INSTR('xbar', 'foobar');   
        ----------------------------------------------------   



2. 숫자함수

        ----------------------------------------------------

         SELECT ABS(-35); --절대 값
         SELECT SIGN(-10); SELECT SIGN(0); SELECT SIGN(10); -- -냐 + 냐(sign은 부호를 뜻한다)
         SELECT ROUND(3.141592); SELECT ROUND(3141.592); --소수점 반올림하고 버리기
         SELECT ROUND(3.141592, 2); --소수점 두번째 자리까지 출력(반올림)
         SELECT ROUND(3.141592, 4); --소수점 4번째 자리까지 출력(반올림)
         SELECT MOD(17, 5); --나머지 값
         SELECT POWER(2, 2); --2의 제곱
         SELECT POWER(2, 8); --2의 8제곱
         SELECT SQRT(25);  -- 숫자의 양수 제곱근을 반환한다(제곱근 = 그 숫자 그대로 루트안에 들어간걸 푼 값)
         SELECT SQRT(5);

        ----------------------------------------------------



3. 날짜함수

        ----------------------------------------------------

         SELECT sysdate();              2021-09-08 19:15:00
         SELECT curdate();              2021-09-08
         SELECT current_date();         2021-09-08
         SELECT curtime();              19:17:23
         SELECT current_time();         19:16:09
         SELECT current_timestamp();    2021-09-08 19:16:22

         SELECT date_format(NOW(), '%Y년 %m월 %d일 %H시 %i분 %S초');
            %i	Minutes, numeric (00..59)
            %j	Day of year (001..366)
            %k	Hour (0..23)
            %l	Hour (1..12)
            %M	Month name (January..December)
            %m	Month, numeric (00..12)
            %p	AM or PM
            %r	Time, 12-hour (hh:mm:ss followed by AM or PM)
            %S	Seconds (00..59)
            %s	Seconds (00..59)
            %T	Time, 24-hour (hh:mm:ss)
            %U	Week (00..53), where Sunday is the first day of the week; WEEK() mode 0
            %u	Week (00..53), where Monday is the first day of the week; WEEK() mode 1
            %V	Week (01..53), where Sunday is the first day of the week; WEEK() mode 2; used with %X
            %v	Week (01..53), where Monday is the first day of the week; WEEK() mode 3; used with %x
            %W	Weekday name (Sunday..Saturday)
            %w	Day of the week (0=Sunday..6=Saturday)
            %X	Year for the week where Sunday is the first day of the week, numeric, four digits; used with %V
            %x	Year for the week, where Monday is the first day of the week, numeric, four digits; used with %v
            %Y	Year, numeric, four digits
            %y	Year, numeric (two digits)
            %%	A literal % character
            %x	x, for any “x” not listed above

         SELECT YEAR(sysdate());
         SELECT MONTH(sysdate());
         SELECT DAY(sysdate()); 
         SELECT HOUR(sysdate());
         SELECT MINUTE(sysdate()); 
         SELECT SECOND(sysdate()); 

        ----------------------------------------------------
    
    > 아이돌멤버 중에서 생일이 지나지 않은 멤버를 모두 출력하시오
        ----------------------------------------------------
        select member_name, birthday
        -> from idol_member
        -> where substr(birthday, 5,4) - date_format(now(), '%m%d') > 0;

        select group_name, member_name, substr(birthday, 5,4) `BIRTH`
        -> from idol_member
        -> where date_format(birthday, '%m%d') >= date_format(now(), '%m%d')
        -> order by `BIRTH`;
        ----------------------------------------------------



4. 변환함수(CAST/CONVERT)
   : INSERT, UPDATE 로 컬럼에 값을 넣어야 하는 경우 설정한 데이터 타입으로 형변환 

        ----------------------------------------------------

         SELECT CAST(NOW() AS SIGNED);
         SELECT CAST(NOW() AS YEAR);
         SELECT CAST(NOW() AS DATE);
         SELECT CAST(NOW() AS TIME);
         SELECT CAST('20210915' AS DATE);

         SELECT CONVERT(NOW(), SIGNED);
         SELECT CONVERT(NOW(), DATE);
         SELECT CONVERT('20210915', SIGNED);

         SELECT CAST('12.34' AS UNSIGNED INTEGER);
         SELECT CAST(1234 AS CHAR(10));

         BINARY
         CHAR
         INTEGER
         DECIMAL
         DATE
         DATETIME
         SIGNED
         UNSIGNED

         SELECT BINARY 'A'='B'; --false = 0 리턴
         SELECT BINARY 'A'='A'; --true = 1 리턴

         SELECT CONVERT('A', BINARY);
         SELECT CONV(3, 10, 2);
         SELECT CONV(11, 10, 16);
         

         SELECT FORMAT(123456789, 0);
         SELECT FORMAT(123456789, 2);

        ----------------------------------------------------   


5. NULL 관련 함수
   : 컬럼 값이 NULL 인지 아닌지 확인 필요

        ----------------------------------------------------
         SELECT NULL + 3;
        ----------------------------------------------------

    > 멤버테이블에서 전화번호(PHONE)가 NULL 인 레코드를 추출하시오 
        ----------------------------------------------------
         SELECT * FROM MEMBER
         WHERE PHONE IS NULL;
        ----------------------------------------------------   
    
    > 멤버테이블에서 전화번호(PHONE)가 NULL 이면 '9999-99-99'로 출력하시오 
        ----------------------------------------------------
        select phone, ifnull(phone, '9999-99-99') from member
        -> where phone is null;
        ----------------------------------------------------


