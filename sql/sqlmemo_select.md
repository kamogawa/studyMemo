#### select의 기본  
 - select 뒤에 붙는 열명을 셀렉트 리스트 또는 선택리스트 라고 한다.
##### 열별명
 - 「select　열명 as 열별명」 을 지정  
 - 아래의 경우 ""로 열별명을 감싸야 한다. (보통 ""을 사용하는 것을 추천)
 ※ ''은 문자 리테럴을 지정할때 사용 ""은 열별명, 오브젝트명 지정시 사용
```
1. 오라클의 예약어
2. 첫 문자가 숫자 또는 기호
3. 대문자 소문자를 구별하고 싶을 경우
4. $,_,# 이외의 기호를 포함
5. 스페이스를 포함
```
 - ORDER BY 이외에는 "열을 지칭하는 이름"으로서 열별명을 사용할 수 없음 
 
 ### 데이터 형
 열은 열명과 데이터형이 지정 되야함 
 ```
 NUMBER 정수 소수
 CHAR(n) n바이트 고정길이 문자열 1~2000 기본값 1, 지정 자리보다 부족할 경우 스페이스가 체워짐
 VARCHAR2(n) n바이트 가변길이 문자열 1~4000 n지정 필수
 BLOB (large object) 최대 128 테라바이트 바이너리 데이터, 이미지나 음성 등을 저장할때 사용 
 CLOB (large object) 최대 128 테라바이트 문자열, char, varchar 보다 큰 문자열 저장할때 사용 
 DATE 밀리세컨드 포함하지 않는 날짜
 TIMESTAMP 밀리세컨드 포함 날짜
 
 LONG 가변길이 문자열 2기가
 BFILE 외부파일에 격납되는 바이너리데이터 4기가
 RAW 바이너리데이터 1~2000
 LONG RAW 바이너리 데이터, 2기가
 TIMESTAMP WITH TIME ZONE 날짜 시간 타임존 정보
 TIMESTAMP WITH LOCAL THIME ZOME 정규화된 날짜 시각
 INTERVAL YEAR TO MONTH 년월 시간간격
 INTERVAL DAY TO SECOND 일시분초 시간간격
 ```
##### NUMBER
 - NUMBER(n) n자리수 정수 지정 안할시 최대치가 설정 
 - NUMBER(n,m) n정수(m소수점) 포함 자리수, n은 1~38, 정수 부분은 n-m　
 - 괄호를 정도라고 부르기도 함
 - 정수 설정치를 넘을 경우: [ORA-01438: この列に許容される指定精度より大きな値です](https://oracle.programmer-reference.com/ora-01438/)
 - 소수 설정치를 넘을 경우: 반올림

##### CREATE TABLE
 - 한 테이블에 컬럼은 최대 1000개
 - CREATE TABLE 시스템 권한, 테이블스페이스 할당량 제한이 할당 되어야함

##### DESCRIVE
 - DESC[RIBE] Sqlplus 커맨드 표구조 확인.
 - 열명, NULL?, 형 이 표시됨

##### DUAL표
 - DB생성시 자동생성 VARCHAR2형의 DUMMY열 1개를 갖고 있음, 실행결과 1행만 출력
 - 정수계산식의 실행결과 
 - 함수의 실행결과 
 - 일반적인표에서도 정수식이 사용가능하지만 표의 행수만큼 출력되기 때문에 사용 안함

##### 산술연산
 - 숫자리테럴: 숫자나 그자체
 - where이나 select등 sql의 다양한 곳에서 산술식을 사용할 수 있다.
 - 우선순위는 보통 수식과 같음
 - 
##### 문자열연결
 - 문자리테럴: 문자 그자체 ''로 감싸서 표현
 - || 연결연산자: 문자데이터형 열의 검색결과에 연결하여 출력함, 3개 이상의 문자열을 연결 가능
 - 문자 리테럴 안에 「'」을 사용하고 싶은 경우, 2가지 방법이 있음
   -  대체인용메커니즘: q' + 임의문자열　ex) q'#x'xx#' 
   -  임의 문자에 괄호를 사용할 경후 열고 닽는 [] 한쌍으로 사용해야 한다. ex) q'[x'xx]' 
##### 날짜 
 - 날짜 데이터를 얻는 방법 
```
TO_DATE함수에 날짜포멧과 문자열 지정 
TO_DATE함에를 문자열만 지정 NLS_DATE_FORMAT에 설정된 값으로 변환, NLS_DATE_FORMAT 사전에 설정필요
문자열이 NLS_DATE_FORMAT에 설정된 날짜 형식으로 변환
날짜 리테럴을 사용하여 변환, 시간은 설정 못함 00:00:00 으로 설정됨
```
 - NLS_DATE_FORMAT의 역활, 표시서식 & 변환시 서식지정
 - 설정 방법: ALTER SESSION SET NLS_DATE_FORMAT='날짜포멧'
 - 초기설정치: (시간은 포함되지 않음)
   - NLS＿TERRITORY=AMERICA NLS_DATE_FORMAT=DD-MON-RR
   - NLS＿TERRITORY=JAPAN NLS_DATE_FORMAT=DD-MON-RR
   - 「SHOW PARAMETER NLS_DATE_FORMAT」 으로 확인후 시간표시가 가능한 설정으로 변경
   - ex) ALTER SESSION SET　NLS_DATE_FORMAT='YYYY/MM/DD HH24:MI:SS'
날짜 포멧
 - YYYY, YY, RR 년
 - MM(01~12), MONTH 축약형:MON: NLS_LANGUAGE, NLS_DATA_LANGUAGE에 설정된 언어에 따른 값에 따라
 - DD(01~31), D(1~7 1이 일요일), DAY 요일명, DY 언에에 따라 
 - HH24, HH(12시간 표기)
 - MI, SS, FF 분 초 미리초 
 - AM 오전 오후 
 - TZR 타임존 

영어환경(NSL_LANGUAE(언어표시)='AMERICAN' NLS_TERRITORY(지역)='AMERICA')의 차이점 ※설정치는 대소문자를 구별 안함  
 - 화면출력이나 메세지가 영어
 - 날짜 데이터 취급

TIMESTAMP: 미리초를 설정, NLS_TIMESTAMP_FORMAT으로 포멧 설정

##### NULL
 - 값이 비었거나, 불명인 상태, 가급적 사용하지 않는것이 좋다.
 - 오라클에서는 공문자열「''」은 Null로 취급한다. (특유의 동작)
 - NULL의 설정 방법 3 가지
   - 직접 Null을 설정, 설정 생략, ''을 설정 
 - Null을 포함한 산술식은 항상 NULL을 반환한다. 
 - 문자열과 Null연결은 문자열을 반환
 - 검색시 IS NULL, IS NOT NULL 의 전용 Null조건을 사용한다. Null로 비교해도 검색이 안됨.
 - Null에 대해여 NULL조건 이외의 Null검색시 항상 불명 처리되어 false로 간주된다. (검색불가)

##### WHERE 
 - 조건값을 지정시 문자열은 ''로 감싸줘야한다. 
 - 문자열 검색시 알파벳 대소문자는 구별된다.
 - 날짜데이터는 알맞은 방법으로 지정한다. TO_DATE함수등을 사용하면 NLS_DATE_FORMAT초기화 파라메터 설정에 의존하지 않고 데이터 설정이 가능함.
 - 조건식으로 열별명은 사용 불가능함 
 - 조건의 평가순서: ()　괄호로 우선순위 변경 가능
 ```
  1. 등가 비교, 
  2. NULL, LIKE, BETWEEN, IN, EXISTS 
  3. NOT
  4. AND
  5. OR
 ```  
  - 등가조건: 검색조건이 일치할 경우 참
  - 비등가조건: 일치하지 않는경우 참 (!=, ^=, <>)
  - 비교조건: 지정한 대소관계가 성립하는 경우 참
  - LIKE조건: 지정한 문자열 패턴과 일치하는 경우 참(%: 공문자를 포함한 임의의 문자열, _ :임의의 1문자)
  - IN조건: 복수대상 검색 (in조건은 or조건으로 바꿔 사용할 수 있다.)
  - BETWEEN조건: 특정 범위에 포함되는 경우 참 (and조건으로 바꿔 사용할수 있음)
  - NULL조건: null을 검색하는 조건
  - NOT조건: 다른 조건과 조합하여 사용, 참이 아닐경우를 검색
  - AND조건: 2개의 조건이 모두 참 
  - OR조건: 2개의 조건중 어느 한쪽이 참

##### ORDER BY
 - 정렬할 경우 반드시 지정해야 한다. 결과값이 정렬된거 같아 보여도 사실 정렬된 것이 아님.
 - 생략시 기본값은 오름차순으로 설정됨, 문자열은 A->Z 날짜 지난시간 -> 현재시간 으로 정렬
 - 열별명으로 정렬 가능
 - select의 뒤에 열거한 열의 위치순서로 지정가능 
 - 복수의 열을 정렬 가능
 - selcect 하지 않은 열로도 정렬 가능
 - null일 경우 오른차순일 경우 끝에 표시되고, 내림차순일 경우 선두에 표시된다.
 - NULL FIRST(앞), NULL LAST(끝)를 지정하여 NULL의 표시위치를 지정할수 있다.
 - 오름차순: ASC(ascending order) 1-2-3-4
 - 내림차순: DESC(descending order) C-B-A

##### 치환변수
 - sql plus sql developer 에서 사용가능 다른 어플리케이션에서는 사용불가
 - 일부만 다르고 비슷한 sql을 실행할때 편리
 - 1. 치환변수를 입력값으로 대화적으로 치환, 「&변수명」 「&&변수명」를 두개로설정하면 변수를 저장하여 같은 이름의 변수를 자동 대입
 - 2. DEFINE 커맨드를 사용하여 sql 실행전에 변수를 지정
 - sqlplus가 종료 되거나, undefinde 커맨드로 설정해지 하기 전까지 유지 됨
 - SET VERIFY OFF를 설정해 치환변수 변화메시지를 비표시 할 수 있음.
 - 문자열 입력시 ''로 감싸 줘야함

