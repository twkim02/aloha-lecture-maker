# ALOHA 강의자료 latexmk 설정
# - XeLaTeX 사용 (한글 폰트 / fontspec)
# - minted 사용을 위한 -shell-escape
# 사용법 (레포 루트에서):
#   latexmk main.tex
#   latexmk lectures/week01-complexity.tex
$pdf_mode = 5;    # 5 = xelatex (.xdv 경유)
set_tex_cmds('-shell-escape -interaction=nonstopmode -synctex=1 %O %S');
