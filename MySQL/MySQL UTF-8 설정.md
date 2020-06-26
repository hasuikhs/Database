# MySQL UTF-8 설정

## 1. Database

### 1.1 생성

```mysql
CREATE DATABASE DB이름 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```

### 1.2 변경

```mysql
ALTER DATABASE DB이름 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```

## 2. Table

### 2.1 생성

```mysql
CREATE TABLE 테이블명( ... ) DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```

### 2.2 변경

```mysql
ALTER TABLE 테이블명 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```

## 3. Server/Client 

- 리눅스에서

  ```bash
  $ vi /etc/my.cnf
  ```

- 변경 사항

  ```
  [mysql]
  default-character-set = utf8
  
  [client]
  default-character-set = utf8
  
  [mysqld]
  character-set-client-handshake=TRUE (클라이언트의 캐릭터셋을 무시하고 서버의 세팅을 따름)
  init_connect=SET collation_connection = utf8_general_ci
  init_connect=SET NAMES utf8
  character-set-server = utf8
  collation-server = utf8_general_ci
  default-collation = utf8_general_ci
  default-character-set = utf8
  ```

- 저장 후 재시작

  ```bash
  $ service mysqld restart
  ```



