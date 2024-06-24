## Global DNS Checking

이 스크립트는 전 세계 여러 DNS 서버에서 DNS 조회를 수행하며, 사용자가 DNS 레코드 유형, 도메인 및 선택적으로 국가를 지정하여 필터링할 수 있습니다.

### 사전 준비

스크립트를 실행하기 전에 시스템에 다음 패키지가 설치되어 있는지 확인하십시오:
- `curl`
- `jq`
- `dig`

### 스크립트 사용법

```bash
./Gdig.sh [DNS_RECORD_TYPE] [DOMAIN] [COUNTRY]
```

- `DNS_RECORD_TYPE`: 조회할 DNS 레코드 유형 (예: A, AAAA, MX 등). 이 매개변수는 필수입니다.
- `DOMAIN`: 조회할 도메인 이름. 이 매개변수도 필수입니다.
- `COUNTRY`: (선택 사항) 국가 코드를 사용하여 DNS 서버를 국가별로 필터링합니다 (예: US, KR, JP). 생략하면 모든 사용 가능한 DNS 서버를 조회합니다.

### 사용 예시

1. `www.cdnetworks.com`의 A 레코드 Global DNS lookup:
    ```bash
    ./script.sh A www.cdnetworks.com
    ```

2. `www.cdnetworks.com`의 CNAME 레코드 US DNS Lookup:
    ```bash
    ./script.sh CNAME example.com US
    ```

### 함수 설명

#### `check_pkgs()`
이 함수는 필요한 패키지(`curl`, `jq`, `dig`)가 설치되어 있는지 확인합니다. 패키지가 하나라도 누락된 경우 오류 메시지와 함께 종료합니다.

#### `_line()`
이 함수는 출력 섹션을 더 잘 구분하기 위해 터미널에 가로선을 출력합니다.

#### `_myip()`
이 함수는 `api.myip.com` 서비스를 사용하여 로컬 머신의 공용 IP 주소와 국가를 가져옵니다.

#### `dns_check()`
이 함수는 지정된 DNS 서버를 사용하여 도메인 및 레코드 유형에 대한 DNS 조회를 수행합니다. 조회 결과를 형식화하여 출력합니다.

#### `local_lookup()`
이 함수는 지정된 국가가 대한민국(`kr`)인 경우에 사전 정의된 로컬 DNS 서버를 사용하여 DNS 조회를 수행합니다.

### 사전 정의된 변수

- `FIXED_DNS_SERVERS`: ID, 국가, 위치 및 제공업체와 함께 고정된 DNS 서버 목록입니다.
- `DNS_SERVERS`: `whatsmydns.net`에서 가져온 DNS 서버 목록과 `FIXED_DNS_SERVERS`를 결합한 목록입니다.
- `SORT_UNIQ_SERVERS`: 중복을 피하기 위해 정렬되고 고유한 DNS 서버 목록입니다.
- `LOCAL_LOOKUP`: 대한민국을 위한 로컬 DNS 서버 목록입니다.

### 스크립트 워크플로우

1. 스크립트는 입력 인수를 검증하고 필요한 패키지를 확인하는 것으로 시작합니다.
2. 일관성을 위해 DNS 레코드 유형 및 국가 코드를 대문자로 변환합니다.
3. 온라인 및 고정 서버 목록을 결합하여 DNS 서버 목록을 컴파일하고, 제공된 국가를 기준으로 필터링합니다.
4. 지정된 도메인 및 레코드 유형에 대해 각 서버에서 DNS 조회를 수행하고 결과를 출력합니다.
5. 국가가 대한민국(`kr`)으로 설정된 경우, 사전 정의된 로컬 DNS 서버를 사용하여 로컬 DNS 조회도 수행합니다.

### 참고 사항

- 스크립트는 외부 서비스(`whatsmydns.net`, `api.myip.com`)를 사용하며 인터넷 연결이 필요합니다.
- 결과는 `jq`를 사용하여 쉽게 읽을 수 있도록 형식화되었습니다.

---

스크립트와 관련된 문제나 질문이 있는 경우, 스크립트 주석을 참조하거나 스크립트 작성자에게 문의하십시오.
