--------------
뷰(VIEW) 생성하기

뷰(VIEW): 데이터를 보여주는 역할만...,
          일종의 가상 테이블,
          물리적으로 저장하지 않는다(삽입/삭제/갱신 작업 제한),
          테이블의 직접적인 접근 제어,
          사용자 권한에 따라 필요한 필드만 보여준다.
____________________________________________________________

-- 복잡하고 어려운 쿼리문으로 조회를 수행해야 할 때,
-- 매번 작성해야 하는 번거로움을 해결해 준다.


[VIEW TABLE 생성];
--------------------------------------------------------------------
CREATE VIEW view_idol_member_age
AS
(
    SELECT GROUP_NAME, MEMBER_NAME, YEAR(NOW())-YEAR(BIRTHDAY)+1 AGE
    FROM IDOL_MEMBER
);z

CREATE VIEW view_notice_regcount
AS
(
    SELECT WRITER_ID, COUNT(ID) CNT
    FROM NOTICE
    GROUP BY WRITER_ID
    ORDER BY CNT DESC
);

CREATE VIEW view_member_secure
AS
(
    SELECT ID, NAME, GENDER
    FROM MEMBER
);
--------------------------------------------------------------------


[VIEW TABLE 사용];
--------------------------------------------------------------------
SELECT * FROM view_idol_member_age;
SELECT * FROM view_notice_regcount;
SELECT * FROM view_member_secure;
--------------------------------------------------------------------