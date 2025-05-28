# Re:NT :: 렌탈 & 중고거래 통합 플랫폼
***Re:NT***는 “빌리고 사고파는 모든 것”을 하나의 서비스 안에서 해결할 수 있도록 만든 **렌탈 & 중고거래 플랫폼**입니다.  
중고 마켓의 ‘구매·판매’ 기능과 대여 전문 플랫폼의 ‘렌탈’ 기능을 결합해 **물건의 전체 수명 주기를 관리**할 수 있게 했습니다.

---

## 시연 영상
[![Re:NT 기능 시연 영상](https://img.youtube.com/vi/YourVideoID/0.jpg)](https://youtu.be/YourVideoID)  
*클릭 시 YouTube에서 전체 시연 영상을 확인할 수 있습니다.*

---

&nbsp;🚚&nbsp; [1. 서비스 소개](#1)   
&nbsp;🚚&nbsp; [2. 팀원 소개](#2)   
&nbsp;🚚&nbsp; [3. 개발 기간](#3)   
&nbsp;🚚&nbsp; [4. 역할 분담](#4)   
&nbsp;🚚&nbsp; [5. 기능 시연](#5)   
&nbsp;🚚&nbsp; [6. 시연 영상](#6)   
&nbsp;🚚&nbsp; [7. 코드 특징과 구현 방식](#7)   
&nbsp;🚚&nbsp; [8. 트러블슈팅](#8)   
&nbsp;🚚&nbsp; [9. 프로젝트를 마치며](#9) 

---

## <span id="1">1. 서비스 소개</span>
* **렌탈/중고 통합** → 판매·대여·무료나눔을 한 화면에서 등록  
* **안전결제 + 보증금** → 대여 시 자동 보증금 결제 & 반납 완료 후 자동 정산  
* **관리자 백오피스** → 회원·카테고리·상품·정산·FAQ·알림 등 8개 모듈 관리  
* **실시간 쪽지 & 알림** → 거래 단계별 FCM PUSH  
* **등급 정산 수수료** → 브론즈 5% ~ Re:NT 2.5% 차등 적용  

---

## <span id="2">2. 팀원 소개</span>

| 👩🏻‍💻 **FE 리더 김개발** | 🧑🏻‍💻 **BE 리더 박백엔드** | 🧑🏻‍🎨 **UI/UX 이디자인** | 🧑🏻‍🔧 **DevOps 최배포** |
|:---:|:---:|:---:|:---:|
| 🔗 [GitHub](https://github.com/kimdev) | 🔗 [GitHub](https://github.com/parkbe) | 🔗 [Behance](https://behance.net/leeux) | 🔗 [GitHub](https://github.com/choidevops) |
| 프론트 설계·공통 컴포넌트 | REST API·DB 모델링 | 프로토타입·Figma | CI/CD·테스트 자동화 |

> **Organization : 20세기 라이언 2팀**  
> 팀 슬로건 — *“빌리는 쉽게, 쓰임은 길게!”*

---

## <span id="3">3. 개발 기간</span>
| 단계         | 기간               | 주요 작업                        |
|------------|------------------|-------------------------------|
| 기획 & 디자인 | 2025/02/24 – 03/03 | 페르소나·와이어프레임·Figma       |
| 1차 개발      | 03/04 – 03/24    | 핵심 도메인(상품·주문·렌탈) 구현    |
| 2차 개발      | 03/25 – 04/15    | 관리자 백오피스·정산 로직          |
| 마감/리팩터링 | 04/16 – 05/02    | 테스트·CI/CD 정비·문서화          |

---

## <span id="4">4. 역할 분담</span>
<img src="./docs/images/role_distribution.png" width="600" />

---

## <span id="5">5. 기능 시연</span>
### 1) 관리자 대시보드
| [회원관리](./docs/images/admin_member.png) | [카테고리관리](./docs/images/admin_category.png) | [상품관리](./docs/images/admin_product.png) |
| :-----------------------------------------: | :---------------------------------------------: | :-----------------------------------------: |
| ![회원관리](./docs/images/admin_member.png) | ![카테고리관리](./docs/images/admin_category.png)  | ![상품관리](./docs/images/admin_product.png) |

| [주문/정산관리](./docs/images/admin_order.png) | [고객지원/FAQ](./docs/images/admin_faq.png) | [알림관리](./docs/images/admin_notify.png) |
| :-------------------------------------------: | :----------------------------------------: | :----------------------------------------: |
| ![주문관리](./docs/images/admin_order.png)     | ![고객지원](./docs/images/admin_faq.png)    | ![알림관리](./docs/images/admin_notify.png) |

### 2) 사용자 화면
| [메인 피드](./docs/images/user_home.png) | [상품 상세](./docs/images/user_product_detail.png) | [렌탈 신청](./docs/images/user_rent.png) |
| :---------------------------------------: | :------------------------------------------------: | :----------------------------------------: |
| ![홈](./docs/images/user_home.png)        | ![상품상세](./docs/images/user_product_detail.png) | ![렌탈](./docs/images/user_rent.png)      |

| [마이페이지](./docs/images/user_profile.png) | [찜/리뷰](./docs/images/user_wishlist.png) |
| :-------------------------------------------: | :-----------------------------------------: |
| ![프로필](./docs/images/user_profile.png)     | ![찜/리뷰](./docs/images/user_wishlist.png) |

---

## <span id="7">7. 코드 특징과 구현 방식</span>
1. **모듈화된 컴포넌트 구조**  
   - `common`, `product`, `order` 등 도메인별 컴포넌트 분리  
2. **Custom Hook 활용**  
   - `useAuth`, `useFetch`, `useModal` 등 재사용 가능한 훅 구현  
3. **서비스 추상화**  
   - RestTemplate / Axios로 API 호출부 분리  
4. **데이터베이스 매퍼**  
   - MyBatis Mapper로 SQL 관리, Annotation 기반 매핑  
5. **안정성 강화**  
   - JWT 기반 인증/인가, 예외 처리 및 전역 에러 핸들러 구현  

---

## <span id="8">8. 트러블슈팅</span>
1. **이미지 업로드 에러**  
   - **문제**: Multipart 요청 시 `400 Bad Request`  
   - **원인**: `@RequestPart` 대신 `@RequestParam` 사용  
   - **해결**: 컨트롤러 시그니처 수정 후 `multipartResolver` 설정 추가  

2. **카테고리 정렬 미반영**  
   - **문제**: 순위 변경 후 화면 갱신이 반영되지 않음  
   - **원인**: 클라이언트 캐싱된 데이터 사용  
   - **해결**: API 호출 후 `useEffect` 의존성 배열에 상태 추가  

3. **로그인 후 새로고침 시 세션 유실**  
   - **문제**: 토큰이 로컬스토리지에 있으나 상태가 초기화됨  
   - **원인**: Redux store 초기화  
   - **해결**: 앱 진입 시 로컬스토리지에서 토큰 복원 로직 추가  

---

## <span id="9">9. 프로젝트를 마치며</span>
이번 Re:NT 프로젝트를 통해 **풀스택 애플리케이션** 개발 경험을 쌓았습니다.  
- **프론트엔드**: 컴포넌트 재사용과 상태 관리 개선  
- **백엔드**: MyBatis 매퍼 효율화 및 에러 핸들링 강화  
- **협업**: GitHub Flow와 데일리 스크럼으로 안정적인 배포 경험  

완벽하지 않을 수 있지만, 실제 운영 가능한 플랫폼으로 완성했다는 점에서 매우 뜻깊었습니다.  
함께 고생한 팀원 모두에게 감사드리며, 앞으로도 더 나은 코드와 서비스를 위해 계속 발전해 나가겠습니다!

---

## <span id="7">개발 환경</span>
🚀 **Frontend**  
![jQuery](https://img.shields.io/badge/jQuery-0769AD?style=flat&logo=jquery&logoColor=white)  
![JSON](https://img.shields.io/badge/JSON-000000?style=flat&logo=json&logoColor=white)  
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black)  
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=css3&logoColor=white)  
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white)  

⚙️ **Backend**  
![JSP](https://img.shields.io/badge/JSP-007396?style=flat)  
![Servlets](https://img.shields.io/badge/Servlets-6DB33F?style=flat)  
![Java](https://img.shields.io/badge/Java-007396?style=flat&logo=java&logoColor=white)  
![MyBatis](https://img.shields.io/badge/MyBatis-005C68?style=flat)  

🖥️ **Server & DB**  
![Apache Tomcat](https://img.shields.io/badge/Apache_Tomcat-F8DC75?style=flat&logo=apachetomcat&logoColor=black)  
![HeidiSQL](https://img.shields.io/badge/HeidiSQL-0055A4?style=flat)  
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat&logo=mariadb&logoColor=white)  

🔌 **External APIs**  
![Toss](https://img.shields.io/badge/Toss_Payments-2E2E2E?style=flat)  
![Kakao Map](https://img.shields.io/badge/KakaoMap-FFCD00?style=flat)  
![Login with Kakao](https://img.shields.io/badge/Login_with_Kakao-FFCD00?style=flat)  
![Login with Naver](https://img.shields.io/badge/Login_with_Naver-03C75A?style=flat&logo=naver&logoColor=white)  
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat&logo=firebase&logoColor=black)  

🎨 **Design & Collaboration**  
![Figma](https://img.shields.io/badge/Figma-F24E1E?style=flat&logo=figma&logoColor=white)  
![Notion](https://img.shields.io/badge/Notion-000000?style=flat&logo=notion&logoColor=white)  
![ERDCloud](https://img.shields.io/badge/ERDCloud-5A29E4?style=flat)  
![Google Sheets](https://img.shields.io/badge/Google_Sheets-34A853?style=flat&logo=google-sheets&logoColor=white)  

🛠️ **CI/CD & VCS**  
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=github-actions&logoColor=white)  
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)
