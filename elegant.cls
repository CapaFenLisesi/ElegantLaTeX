% !Mode:: "TeX:UTF-8"
%-----DONE-----
% * 选项
% ** 默认的选项utf,withchinese,withisomath
% ** 通过utf, gbk来调整编码
% ** 通过dvips, dvipdfm, pdftex, xetex来调整代码适应
% ** 通过withchinese/withoutchinese来开关中文支持
% ** 通过withisomath/withoutisomath来开关iso数学支持
% * 检测编译方式
% * 中文支持
% * 数学支持
% * 交叉引用
% * 字号支持
%-----DONE-----


%-----TODO-----
% * 参考文献引用
% * 页面设置
% * 页眉页脚
% * 段落格式（缩进、间距）
% * 脚注（option）
% * 定理环境定义（中英，option）
% * 定理环境样式（option）
% * 中文标题定义（option）
% * 标题格式（option）
% * 目录格式（option）
% * 附录
%-----TODO-----


%-----基本信息-----
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{elegant}[2013/05/12 Ch'en Meng]
\newcommand{\elegant@version}{0.0.2}
\newcommand{\ElegantVersion}{\elegant@version}
\newcommand{\elegantversion}{\textit{v}\,\ElegantVersion}
%-----基本信息-----


%-----定义选项-----
%----编码
\newif\ifelegant@UTF
\newif\ifelegant@GBK
\DeclareOption{utf}{\elegant@UTFtrue\elegant@GBKfalse}
\DeclareOption{gbk}{\elegant@GBKtrue\elegant@UTFfalse}
%----编译方式
\newif\ifelegant@dvips
\newif\ifelegant@dvipdfm
\newif\ifelegant@xetex
\newif\ifelegant@pdftex
\DeclareOption{dvips}{\elegant@dvipstrue}
\DeclareOption{dvipdfm}{\elegant@dvipdfmtrue}
\DeclareOption{pdftex}{\elegant@pdftextrue}
\DeclareOption{xetex}{\elegant@xetextrue}
%----模块
%--中文
\newif\ifelegant@chinese
\DeclareOption{withoutchinese}{\elegant@chinesefalse}
\DeclareOption{withchinese}{\elegant@chinesetrue}
%--数学
\newif\ifelegant@math
\DeclareOption{withoutisomath}{\elegant@mathfalse}
\DeclareOption{withisomath}{\elegant@mathtrue}
%----载入基础类
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{utf,withchinese,withisomath}
\ProcessOptions\relax
\LoadClass[12pt,a4paper,openany]{book}
%-----定义选项-----


%-----检测编译-----
\RequirePackage{ifpdf,ifxetex}
%----检测xetex
\ifelegant@xetex\RequireXeTeX\fi
%----检测pdftex
\def\RequirePDFTeX{%
  \ifpdf\else
    \ClassError{elegant}%
               {pdflatex is required to compile this document!}{}
  \fi}
\ifelegant@pdftex\RequirePDFTeX\fi
%----根据检测到的编译方式，强制相应选项为真
\def\elegant@checkoption#1#2{%
  \@for\reserved@a:=#2\do{%
    \csname ifelegant@\reserved@a\endcsname
      \ClassError{elegant}%
                 {Please remove `\reserved@a' option when you are running #1.}{}
    \fi}}
\ifpdf\elegant@checkoption{pdflatex}{dvips,dvipdfm,xetex}\elegant@pdftextrue\fi 
\ifxetex\elegant@checkoption{xelatex}{dvips,dvipdfm,pdftex}\elegant@xetextrue\fi
%----检测xetex与gbk的冲突
\ifelegant@xetex
	\ifelegant@GBK
		\ClassError{elegant}%
			{Files encoded with GBK cannot be compiled by XeLaTeX!}{}
	\else\relax\fi
\else\relax\fi
%-----检测编译-----


%-----载入宏包-----
\RequirePackage{ifthen, calc}
\RequirePackage{dtklogos}
%-----载入宏包-----


%-----中文支持-----
\ifelegant@chinese
	\ifelegant@xetex
		\RequirePackage[			%使得能够单独设置中文字体
				SlantFont,			%允许斜体
				BoldFont,			%允许粗体
				CJKchecksingle,		%检查孤字占行
				CJKnumber			%使用CJKnumber
				]{xeCJK}          	%使得能够单独设置中文字体
		\RequirePackage{xunicode}
		\RequirePackage{xltxtra}
		\defaultfontfeatures{Mapping=tex-text}
		\XeTeXlinebreaklocale "zh"			%使用中文的换行风格
		\XeTeXlinebreakskip = 0pt plus 1pt	%调整换行逻辑的弹性大小
		% 字体映射
		\newcommand\fontnameroman{Times New Roman}%TeX Gyre Pagella/Times New Roman
		\newcommand\fontnameblack{Verdana}%Verdana
		\newcommand\fontnamesans{Arial}%Calibri
		\newcommand\fontnamemono{Inconsolata}%Courier New/Inconsolata
		\newcommand\fontnamehei{Adobe Heiti Std}
		\newcommand\fontnamesong{Adobe Song Std}%Adobe Song Std/SimSun
		\newcommand\fontnamefsong{Adobe Fangsong Std}
		\newcommand\fontnamekai{Adobe Kaiti Std}%KaiTi
		\newcommand\fontnameyahei{Microsoft YaHei}%Microsoft YaHei/Yahei Mono/YaHei Consolas Hybrid
		% 英文
		\setmainfont[BoldFont=\fontnameblack]{\fontnameroman}
		\setsansfont[]{\fontnamesans}
		\setmonofont[BoldFont=\fontnamehei]{\fontnamemono}
		% 中文
		\setCJKmainfont[BoldFont=\fontnamehei,ItalicFont=\fontnamekai]{\fontnamesong}			
		\setCJKmonofont{\fontnameyahei}
		\setCJKsansfont[BoldFont=\fontnamehei]{\fontnameyahei}
		
		%楷体
		\newfontinstance\KAI{\fontnamekai}
		\newcommand{\kai}[1]{{\KAI #1}} 
		%黑体
		\newfontinstance\HEI{\fontnamehei}
		\newcommand{\hei}[1]{{\HEI #1}}
		%宋体
		\newfontinstance\SONG{\fontnamesong}
		\newcommand{\song}[1]{{\SONG #1}}
		%仿宋体
		\newfontinstance\FSONG{\fontnamefsong}
		\newcommand{\fsong}[1]{{\FSONG #1}}
	\else
		\RequirePackage{CJKutf8}
		\RequirePackage{CJKnumb}		
		\ifelegant@GBK % CJKpunct 在 UTF 下工作的不好。
			\AtBeginDocument{\begin{CJK}{GBK}{song}}
			\AtEndDocument{\end{CJK}}
		    \IfFileExists{CJKpunct.sty}%
		                 {\RequirePackage{CJKpunct}}%
		                 {\ClassWarning{elegant}{no CJKpunct.sty availiable!}}
		\else
			\AtBeginDocument{\begin{CJK}{UTF8}{song}}
			\AtEndDocument{\end{CJK}}
		\fi
		\RequirePackage{CJKspace}
	\fi
\else\relax
\fi
%-----中文支持-----


%-----iso数学支持-----
\ifelegant@math
	\RequirePackage{amsmath}
	\RequirePackage{amsfonts}
	\RequirePackage{amsthm}
	\RequirePackage{amssymb}
	\RequirePackage{amsbsy}
	\RequirePackage{bm}
	\RequirePackage{mathrsfs}
	\RequirePackage{upgreek}
	\newcommand*{\VEC}[1]{\ensuremath{\boldsymbol{#1}}}	%向量
	\newcommand*{\me}{\ensuremath{\mathrm{e}}}			%自然对数的底
	\newcommand*{\mi}{\ensuremath{\mathrm{i}}}			%虚数单位
	\newcommand*{\dif}{\ensuremath{\,\mathrm{d}}}			%微分算子
	\newcommand*{\mpi}{\ensuremath{\uppi}}
	\DeclareMathAlphabet{\mathsfsl}{OT1}{cmss}{m}{sl}
	\newcommand*{\MATRIX}[1]{\ensuremath{\mathsfsl{#1}}}	%矩阵名称
	\newcommand*{\TENSOR}[1]{\ensuremath{\mathsfsl{#1}}}	%张量名称
	\newcommand*{\HUA}[1]{\ensuremath{\mathscr{{#1}}}} 		%输出花体字母
	\newcommand*{\SHUANG}[1]{\ensuremath{\mathbb{{#1}}}}	%输出双线字母
	\renewcommand{\frac}[2]{{\,#1\,\over\,#2\,}}
	\numberwithin{equation}{chapter}
\else\relax\fi
%-----iso数学支持-----


%-----参考文献-----
\RequirePackage[numbers,super,sort&compress]{natbib}
%-----参考文献-----


%-----超 链 接-----
\RequirePackage{hyperref}
\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=false}
\fi
\hypersetup{%
	colorlinks, 
	linkcolor = black, 
	anchorcolor = black, 
	citecolor = black
}
\ifelegant@dvips
  \RequirePackage{breakurl}
\fi
\urlstyle{same}
\RequirePackage{hypernat}
%-----超 链 接-----


%-----字号设置-----
\ifelegant@xetex
	\newcommand{\xeCJKfontsize}[4]{%
	\fontsize{#1}{#2 plus#3 minus #4}\selectfont}
	\newcommand\zihao[1]{%
	\ifthenelse{\equal{#1}{0}}{%
	\xeCJKfontsize{42bp}{50.4pt}{.5pt}{.3pt}}{}%
	\ifthenelse{\equal{#1}{0-}}{%
	\xeCJKfontsize{36bp}{43.2pt}{.5pt}{.3pt}}{}%
	\ifthenelse{\equal{#1}{1}}{%
	\xeCJKfontsize{28bp}{31.2pt}{.5pt}{.3pt}}{}%
	\ifthenelse{\equal{#1}{1-}}{%
	\xeCJKfontsize{24bp}{28.8pt}{.5pt}{.3pt}}{}%
	\ifthenelse{\equal{#1}{2}}{%
	\xeCJKfontsize{21bp}{26.4pt}{.5pt}{.3pt}}{}%
	\ifthenelse{\equal{#1}{2-}}{%
	\xeCJKfontsize{18bp}{21.6pt}{.3pt}{.2pt}}{}%
	\ifthenelse{\equal{#1}{3}}{%
	\xeCJKfontsize{15.75bp}{19.3pt}{.3pt}{.2pt}}{}%
	\ifthenelse{\equal{#1}{3-}}{%
	\xeCJKfontsize{15bp}{18pt}{.3pt}{.2pt}}{}%
	\ifthenelse{\equal{#1}{4}}{%
	\xeCJKfontsize{14bp}{16.8pt}{.3pt}{.2pt}}{}%
	\ifthenelse{\equal{#1}{4-}}{%
	\xeCJKfontsize{12bp}{14.4pt}{.3pt}{.2pt}}{}%
	\ifthenelse{\equal{#1}{5}}{%
	\xeCJKfontsize{10.5bp}{12.6pt}{.3pt}{.2pt}}{}%
	\ifthenelse{\equal{#1}{5-}}{%
	\xeCJKfontsize{9bp}{10.8pt}{.2pt}{.1pt}}{}%
	\ifthenelse{\equal{#1}{6}}{%
	\xeCJKfontsize{7.875bp}{9pt}{.2pt}{.1pt}}{}%
	\ifthenelse{\equal{#1}{6-}}{%
	\xeCJKfontsize{6.5bp}{7.8pt}{.2pt}{.1pt}}{}%
	\ifthenelse{\equal{#1}{7}}{%
	\xeCJKfontsize{5.25bp}{6.6pt}{.1pt}{.1pt}}{}%
	\ifthenelse{\equal{#1}{8}}{%
	\xeCJKfontsize{5bp}{6pt}{.1pt}{.1pt}}{}}
\else
	\newlength\elegant@linespace
	\newcommand{\elegant@choosefont}[2]{%
	   \setlength{\elegant@linespace}{#2*\real{#1}}%
	   \fontsize{#2}{\elegant@linespace}\selectfont}
	\def\elegant@define@fontsize#1#2{%
	  \expandafter\newcommand\csname #1\endcsname[1][\baselinestretch]{%
	    \elegant@choosefont{##1}{#2}}}
	\elegant@define@fontsize{chuhao}{42bp}
	\elegant@define@fontsize{xiaochu}{36bp}
	\elegant@define@fontsize{yihao}{26bp}
	\elegant@define@fontsize{xiaoyi}{24bp}
	\elegant@define@fontsize{erhao}{22bp}
	\elegant@define@fontsize{xiaoer}{18bp}
	\elegant@define@fontsize{sanhao}{16bp}
	\elegant@define@fontsize{xiaosan}{15bp}
	\elegant@define@fontsize{sihao}{14bp}
	\elegant@define@fontsize{banxiaosi}{13bp}
	\elegant@define@fontsize{xiaosi}{12bp}
	\elegant@define@fontsize{dawu}{11bp}
	\elegant@define@fontsize{wuhao}{10.5bp}
	\elegant@define@fontsize{xiaowu}{9bp}
	\elegant@define@fontsize{liuhao}{7.5bp}
	\elegant@define@fontsize{xiaoliu}{6.5bp}
	\elegant@define@fontsize{qihao}{5.5bp}
	\elegant@define@fontsize{bahao}{5bp}
	\newcommand\zihao[1]{%
		\ifthenelse{\equal{#1}{0}}{\chuhao}{}%
		\ifthenelse{\equal{#1}{0-}}{\xiaochu}{}%
		\ifthenelse{\equal{#1}{1}}{\yihao}{}%
		\ifthenelse{\equal{#1}{1-}}{\xiaoyi}{}%
		\ifthenelse{\equal{#1}{2}}{\erhao}{}%
		\ifthenelse{\equal{#1}{2-}}{\xiaoer}{}%
		\ifthenelse{\equal{#1}{3}}{\sanhao}{}%
		\ifthenelse{\equal{#1}{3-}}{\xiaosan}{}%
		\ifthenelse{\equal{#1}{4}}{\sihao}{}%
		\ifthenelse{\equal{#1}{4-}}{\xiaosi}{}%
		\ifthenelse{\equal{#1}{5}}{\wuhao}{}%
		\ifthenelse{\equal{#1}{5-}}{\xiaowu}{}%
		\ifthenelse{\equal{#1}{6}}{\liuhao}{}%
		\ifthenelse{\equal{#1}{6-}}{\xiaoliu}{}%
		\ifthenelse{\equal{#1}{7}}{\qihao}{}%
		\ifthenelse{\equal{#1}{8}}{\bahao}{}
	}
\fi
%-----字号设置-----
\endinput
%
