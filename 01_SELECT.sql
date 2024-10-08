/*
 * SELECT ( DML 또는 DQL ) : 조회
 * 
 * - 데이터를 조회( SELECT ) 하면 조건에 맞는 행들이 조회됨.
 * 이 떄, 조회된 행들의 집합을 "RESULT SET" 이라고 한다.
 * 
 * - RESERT SET은 0개 이상의 행을 포함할 수 있따.
 * 왜 0개 ? -> 조건에 맞는 행이 없을 수 있기 때문에 
 * 
 */

-- [작성법]
-- SELECT 컬럼명 FROM 테이블명;
--> 테이블의 특정 컬럼을 조회하겠다.

SELECT * FROM EMPLOYEE; -- RESULT set
-- '*' : ALL ,모든 ,전부
--> EMPLOYEE 테이블의 모든 컬럼을 조회하겠다.

-- EMPLOYEE 테이블에서 사번, 직원이름, 휴대전화번호만 조회
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

-------------------------------------------------

-- <컬럼 값 산술 연산>
-- 컬럼 값 : 테이블 내 한 칸 (== 한 셀)에 작성된 값 (DATA)

-- EMPLOEE 테이블에서 모든 사원의 사번, 이름, 급여, 연봉 조회
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 FROM EMPLOYEE;

SELECT EMP_NAME + 10 FROM EMPLOYEE;
-- SQL Error [1722] [42000]: ORA-01722: 수치가 부적합합니다
-- 산술연산은 숫자타입(NUMBER) 만 가능~

SELECT '같음'
FROM DUAL;
WHERE 1 = '1';

--WHERE(조건절) : 문자열안의 숫자를 형변환함

-- 문자열 타입이어도 저장된 값이 숫자면 자동으로 형변환하여 연산 가능
SELECT EMP_ID + 10 FROM EMPLOYEE;

--------------------------------------------------------------------------

-- 날짜(DATE) 타입 조회

-- EMPLOYEE 테이블에서 이름, 입사일, 오늘 날짜 조회

SELECT EMP_ID, HIRE_DATE, SYSDATE FROM EMPLOYEE;

-- SYSDATE : 시스템상의 현재 시간 ( 날짜 ) 를 나타내는 상수

SELECT  SYSDATE  FROM DUAL;
-- DUAL ( DUmmy tAbLe ) 테이블 : 가짜 테이블 ( 임시 조회용 테이블 )

-- 날짜 + 산술연산 ( + , - )
SELECT SYSDATE -1, SYSDATE , SYSDATE +1 
FROM DUAL;
-- 날짜에 + / - 연산 시 일 단위로 계산이 진행됨

------------------------------------------

-- <컬럼에 별칭 지정하기>

/* 컬럼명 AS 별칭 : 별칭 띄어쓰기 x, 특수문자 x, 문자만 o
 * 
 * 컬럼명 AS "별칭" : 별칭 띄어쓰기 o, 특수문자 o, 문자 o
 * 
 * AS 생략 가능
 * 
 * 
 */

SELECT SYSDATE -1 "하루 전", SYSDATE 오늘 , SYSDATE +1 "하루 뒤"
FROM DUAL;

---------------------------------------------

-- JAVA 리터럴 : 값 자체를 의미 
-- DB 리터럴 : 임의로 지정한 값을 기존 테이블에 존재하는 값처럼 사용하는 것
--> (필수) DB의 리터럴 표기법은 '' 홑따옴표

SELECT EMP_NAME, SALARY, '원 입니다' FROM EMPLOYEE;

---------------------------------------------------

-- DISTINCT (중복 제거) : 조회 시 컬럼에 포함된 중복 값을 한번만 표기
-- 주의사항 1) DISTINCT 구문은 SELECT 마다 한번씩만 작성 가능
-- 주의사항 2) DISTINCT 구문은 SELECT 제일 앞에 작성되어야 한다.

SELECT DISTINCT  DEPT_CODE, JOB_CODE FROM EMPLOYEE;

--------------------------------------------------
-- 해석순서
-- 3. SELECT 절 : SELECT 컬럼명
-- 1. FROM 절 : FROM 테이블명
-- 2. WHERE 절(조건절) : WHERE 컬럼명 연산자 값;
-- 4. ORDER BY 컬럼명 | 별칭 | 컬럼 순서 [ ASC(오름차순) | DESC(내림차순)] 
-- [ NULLS FIRST | LAST(NULL값을 먼저, 나중에 보여주기) ]  (정렬)ㅒ 절 : 

-- EMPLOYEE 테이블(FROM 절) 에서 급여가 3백만원 초과인 사원의 (WHERE 절)
-- 사번, 이름, 급여, 부서코드를 조회해라 (SELECT 절)

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 비교 연산자 : > , < , >= , <=, = (같다),[ != ,<> ] (같지 않다)
-- 대입 연산자 : :=

-- EMPLOYEE 테이블에서 부서코드가 'D9' 인 사원의
-- 사번, 이름, 부서코드(DEPT_CODE), 직급코드(JOB_CODE)를 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

---------------------------------------

-- 논리 연산자 ( AND, OR )

-- EMPLOYEE 테이블에서
-- 급여가 300만원 미만 또는 500만원 이상인 사원의
-- 사번, 이름, 급여, 전화번호 조회

SELECT EMP_ID, EMP_NAME , SALARY ,PHONE 
FROM EMPLOYEE
WHERE SALARY < 3000000 OR SALARY >= 5000000;

-- EMPLOYEE 테이블에서
-- 급여가 300만 이상 500만 미만인 사원의
-- 사번, 이름, 급여, 전화번호 조회

SELECT EMP_ID , EMP_NAME , SALARY , PHONE 
FROM EMPLOYEE
WHERE SALARY >= 3000000 AND SALARY < 5000000;

-- BETWEEN A AND B : A 이상 B 이하

-- 300만 이상, 600만 이하

SELECT EMP_ID , EMP_NAME , SALARY , PHONE 
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000;

-- NOT 연산자 사용 가능 BETWEEN 앞에 작성
SELECT EMP_ID , EMP_NAME , SALARY , PHONE 
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 6000000;

-- 날짜 ( DATE ) 에 BETWEEN 사용하기
-- EMPLOYEE 테이블에서 입사일이 1990-01-01 ~ 1999-12-31 사이인 직원의
-- 이름, 입사일 조회

SELECT EMP_NAME , HIRE_DATE 
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '1990-01-01' AND '1999-12-31'; 

-----------------------------------

-- LIKE : 비교하려는 값이 특정한 패턴을 만족시키면 조회하는 연산자

-- [작성법]
-- WHERE 컬럼명 LIKE '패턴이 적용된 값'

-- LIKE의 패턴을 나타내는 문자
-- '%' : 포함
-- '_' : 글자수

-- '%' 예시
-- 'A%' : A로 시작하는 문자열
-- '%A' : A로 끝나는 문자열
-- '%A%' : A를 포함하는 문자열

-- 'A_' : A로 시작하는 두 글자 문자열
-- '____A'(_ X 4 ) : A로 끝나는 다섯 글자 문자열
-- '__A__'(_ X 4 ) : 세번째 문자가 A인 다섯글자 문자열
-- '_____'(_ X 5 ) : 다섯글자 문자열
-- EMPLOYEE 테이블에서 성이 '전'씨인 사원의 사번, 이름 조회

SELECT EMP_ID , EMP_NAME 
FROM EMPLOYEE e 
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서 전화번호가 010으로 시작하지 않는 사원
-- 사번, 이름, 전화번호 조회

SELECT EMP_ID , EMP_NAME , PHONE 
FROM EMPLOYEE e
WHERE PHONE NOT LIKE '010%';

-- EMPLOYEE 테이블에서 EMAIL의 _앞에 글자가 세글자인 사원만
-- 이름, 이메일 조회
SELECT EMP_NAME , EMAIL 
FROM EMPLOYEE e
WHERE EMAIL LIKE '____%';

-- ESCAPE 문자
-- ESCAPE 문자 뒤에 작성된 _는 일반문자로 탈출한다는 뜻
-- #, ^

SELECT EMP_NAME , EMAIL 
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

------------------------------------------

-- 연습문제

-- EMPLOYEE 테이블에서
-- 이메일 '_' 앞이 4글자이면서
-- 부서코드가 'D9' 또는 'D6' 이고
-- 입사일이 1990-01-01 - 2000-12-31 이고
-- 급여가 270만원 이상인 사원의
-- 사번, 이름, 이메일, 부서코드, 입사일, 급여 조회

SELECT * FROM  EMPLOYEE e ;

SELECT EMP_ID , EMP_NAME , EMAIL , DEPT_CODE , HIRE_DATE , SALARY 
FROM EMPLOYEE
WHERE EMAIL LIKE '____#_%' ESCAPE '#' AND 
( DEPT_CODE  = 'D9' OR DEPT_CODE = 'D6' ) AND 
HIRE_DATE BETWEEN '1990-01-01' AND '2000-12-31' AND 
SALARY >= 2700000;

-- 연산자 우선순위

/*
 * 1. 산술 연산자 ( + - * / )
 * 2. 연결 연산자 ( || )
 * 3. 비교 연산자 ( > < >= <= != <> )
 * 4. IS NULL/ IS NOT NULL, LIKE, IN / NOT IN
 * 5. BETWEEN AND / NOT BETWEEN AND 
 * 6. NOT ( 논리 연산자 )
 * 7. AND
 * 8. OR
 * 
 */

-----------------------------------------------

/*
 * IN 연산자
 * 
 * 비교하려는 값과 목록에 작성된 값 중
 * 일치하는 것이 있으면 조회하는 연산자
 * 
 * [작성법]
 * WHERE 컬럼명 IN(값1, 값2, 값3 ... ) 
 * 
 * WHERE 컬럼명 = '값1'
 * 		OR 컬럼명 = '값2'
 * 		OR 컬럼명 = '값3'
 * 
 * */

-- EMPLOYEE 테이블에서
-- 부서코드가 D1, D6, D9인 사원의
-- 사번, 이름, 부서코드 조회

SELECT EMP_ID , EMP_NAME , DEPT_CODE 
FROM EMPLOYEE e 
WHERE DEPT_CODE IN('D1', 'D6', 'D9');

-- NOT IN
SELECT EMP_ID , EMP_NAME , DEPT_CODE 
FROM EMPLOYEE e 
WHERE DEPT_CODE NOT IN('D1', 'D6', 'D9') -- (12명 NULL미포함)
OR DEPT_CODE IS NULL ; -- 부서코드가 없는 2명 포함 14명

-------------------------------------

/*
 * NULL 처리 연산자
 * 
 * JAVA에서 NULL : 참조하는 객체가 없음을 의미
 * DB에서 NULL : 컬럼에 값이 없음을 의미하는 값
 * 
 * 1) IS NULL : NULL인 경우 조회
 * 2) IS NOT NULL : NULL이 아닌 경우 조회
 * 
 * */

-- EMPLOYEE 테이블에서 보너스가 있는 사원의 이름, 보너스 조회
SELECT * FROM EMPLOYEE e ;


SELECT EMP_ID , BONUS 
FROM EMPLOYEE e 
WHERE BONUS IS NOT NULL ; 

------------------------------------------------------------------

/* ORDER BY 절
 * 
 * - SELECT문의 조회 결과 (RESEULT SET)을 정렬할 때 사용하는 구문
 * 
 * ** SELECT 문 해석 시 가장 마지막에 해석된다
 * 
 * */

-- EMPLOYEE 테이블 급여 오름 차순으로
-- 사번 ,이름, 급여 조회

SELECT EMP_ID , EMP_NAME , SALARY 
FROM EMPLOYEE 
ORDER BY SALARY ; -- ASC(오름차순)가 기본값

-- EMPLOYEE 테이블에서 (FROM)
-- 급여가 200만 이상인 사원의 ( WHERE)
-- 사번, 이름, 급여 조회 (SELECT)
-- 단, 급여 내림 차순으로 조회 (ORDER BY)

SELECT EMP_ID , EMP_NAME , SALARY 
FROM EMPLOYEE 
WHERE EMPLOYEE.SALARY >= 2000000
ORDER BY SALARY DESC; -- 컬럼 순서

-- 입사일 순서대로 이름, 입사일 조회

SELECT EMP_NAME 이름, HIRE_DATE 입사일 
FROM EMPLOYEE e 
ORDER BY 입사일 ;
				
-- 정렬 중첩 : 대분류 정렬 후 소분류 정렬 
-- 부서코드 오름차순 정렬 후 급여 내림차순 정렬

SELECT EMP_NAME , DEPT_CODE , SALARY 
FROM EMPLOYEE e 
ORDER BY DEPT_CODE , SALARY DESC ;














