# ALOHA LaTeX 강의자료 템플릿

ALOHA (The algorithm club) 강의자료용 LaTeX(Beamer) 템플릿입니다.
기존 PPT 강의자료(2026-1 중급반)의 디자인을 그대로 재현했습니다.

| 파일 | 설명 |
|---|---|
| `beamerthemeAloha.sty` | ALOHA 테마 (색상/폰트/페이지 장식/컴포넌트) |
| `header.tex` | 공통 프리앰블 (패키지, minted 설정) |
| `main.tex` | **컴포넌트 쇼케이스 데모** — 새 강의는 이 파일을 복사해서 시작 |
| `lectures/week01-complexity.tex` | 실제 강의 포팅 예시 (1주차: 시간 복잡도, 누적 합) |
| `fonts/` | 마루부리(본문) + DM Mono(코드) + Noto Sans KR(코드 한글) |
| `images/` | ALOHA 로고, solved.ac 난이도 아이콘(`0..30.svg.png`), 강의별 그림 |
| `lecture-pdf/`, `lecture-pptx/` | 기존 PPT 강의자료 원본 (참고용) |
| `reference/` | 이 레포의 뿌리인 [UCPC 2020 테마](https://github.com/ucpcc/2020-solutions-theme) 아카이브 (컴파일 대상 아님) |

## 빌드 방법

**반드시 XeLaTeX로 컴파일**해야 하며(한글 폰트), minted 때문에 `-shell-escape`가 필요합니다.
`.latexmkrc`가 둘 다 자동 설정하므로 latexmk만 쓰면 됩니다.

### GitHub Actions (권장)

push하면 `.github/workflows/build.yml`이 **변경된 강의만** 컴파일하고,
Actions 탭 → 해당 런 → Artifacts에서 PDF(`pdf-<파일명>`)를 받을 수 있습니다.

빌드 대상 결정 규칙:
- `lectures/weekNN-*.tex` 또는 `images/weekNN/`만 바꾸면 → **그 강의 1개만** 빌드
- 공통 파일(`beamerthemeAloha.sty`, `header.tex`, `fonts/`, `.latexmkrc`, 공용 이미지)을
  바꾸면 → **전체** 빌드 (테마 변경이 모든 강의에 반영되므로)
- 여러 개가 잡히면 **병렬**로 컴파일하므로 소요 시간은 1개와 비슷합니다
- 전체를 수동으로 다시 빌드하려면: Actions 탭 → Build lecture PDFs → **Run workflow** →
  target에 `all` 입력 (특정 파일 경로를 넣으면 그 파일만)

### Overleaf

1. 레포 전체를 zip으로 올리거나 GitHub 연동으로 프로젝트 생성
2. Menu → **Compiler: XeLaTeX** 로 변경
3. Main document: `main.tex` (또는 원하는 강의 파일)

### 로컬 (TeX Live / MiKTeX + Python Pygments 필요)

```sh
# 레포 루트에서 (fonts/, images/ 상대 경로 때문에 루트 기준 컴파일)
latexmk main.tex
latexmk lectures/week01-complexity.tex
```

## 새 강의 만들기

1. `main.tex`를 `lectures/weekNN-topic.tex`로 복사
2. 메타데이터 수정:

```latex
\deckheader{2026 ALOHA 1학기 멘토링}  % 상단 러닝 헤더
\deckfooter{2026 ALOHA}               % 하단 중앙 문구
\lecturetag{중급반 3주차}             % 타이틀의 "#..." 태그
\title{DP}
\subtitle{Dynamic Programming}        % <> 는 자동으로 붙음
```

3. `.github/workflows/build.yml`의 `root_file`에 새 파일 추가

## 디자인 스펙 (PPT 스펙 슬라이드 → 템플릿 매핑)

| PPT 스펙 | 템플릿 |
|---|---|
| 본문: 마루부리OTF 가는 16pt | 기본 폰트 (documentclass 8pt ≈ 환산 동일) |
| 제목: 마루부리OTF 중간 20pt | 프레임 제목 (`#` 자동 접두) |
| 부제: 마루부리OTF 아주가는 12pt | 프레임 부제 (둘째 인자) |
| 개념 설명: 중간 22pt | `\concept{...}` |
| 부연설명: 아주가는 11pt | `\annot{...}` |
| 볼드: 중간(SemiBold) | `\textbf{...}` |
| 강조색 `#5F2CC6` | `\alert{...}`, 색상명 `aloha-accent` |
| 배경색 `#ECE4F9` | `\hl{...}`, 색상명 `aloha-highlight` |
| 코드: 가독성 폰트+테마 | minted (DM Mono, `vs` 스타일 — `header.tex`에서 교체 가능) |

## 컴포넌트 치트시트

```latex
% 섹션 등록 — 섹션이 시작하는 프레임 "바로 앞"에.
% 타이틀 페이지 우측 목차(페이지 번호 포함)가 자동 생성됨 (2회 컴파일 필요)
\alohasection{누적 합}

% 프레임: 제목("#누적 합")과 부제
\begin{frame}{누적 합}{<Prefix Sum> - 2차원 누적 합}
  ...
\end{frame}

% 텍스트 강조
\alert{보라 강조}  \hl{연보라 형광펜}  \textbf{볼드(SemiBold)}  \annot{회색 부연설명}

% 개념 정의문 (22pt 상당)
\concept{알고리즘의 \alert{성능을 평가하는 지표} 중 하나}

% "<문제 설명>" 스타일 소제목
\subhead{문제 설명}

% 문제 제목 (solved.ac 아이콘 + 이름 + BOJ 링크) — 난이도: 1~5 브론즈, 6~10 실버, 11~15 골드, ...
\problemtitle{8}{구간 합 구하기 4}{11659}

% 문제 리스트 항목 (필수/연습 문제 슬라이드)
\problemitem{8}{구간 합 구하기 4}{11659}{1차원 누적합을 구현해보아요}

% 2단 레이아웃 + 중앙 세로 구분선
\begin{twocol}
  왼쪽 내용
\colsplit
  오른쪽 내용
\end{twocol}

% 코드 (frame에 [fragile] 필수!)
\begin{frame}[fragile]{제목}
  \begin{minted}{cpp}
    int main() { ... }
  \end{minted}
\end{frame}

% 복잡도 표기
\complexity{N \log N}   % O(N log N)

% 마무리 슬라이드 (중앙 대형 로고)
\closingframe

% 표 스타일
\rowcolor{aloha-highlight}            % 헤더 행
\cellcolor{aloha-accent!55}\color{white}4   % 강조 셀
```

## 크레딧

- 인프라 기반: [ucpcc/2020-solutions-theme](https://github.com/ucpcc/2020-solutions-theme) (`reference/`에 보존)
- 폰트: [마루부리](https://hangeul.naver.com/font) (네이버), [DM Mono](https://fonts.google.com/specimen/DM+Mono), [Noto Sans CJK KR](https://github.com/notofonts/noto-cjk)
- 난이도 아이콘: [solved.ac](https://solved.ac)
