% Adapted from https://www.w3.org/TR/2011/REC-CSS2-20110607/grammar.html

Definitions.

H           = [0-9a-fA-F]
NONASCII    = [\240-\377]
UNICODE     = (\\{H}{1,6}(\r\n|[\s\t\r\n\f])?)
ESCAPE      = ({UNICODE}|\\[^\r\n\f0-9a-fA-F])
NMSTART     = ([_a-zA-Z]|{NONASCII}|{ESCAPE})
NMCHAR      = ([_a-zA-Z0-9-]|{NONASCII}|{ESCAPE})
STRING1     = \"([^\n\r\f\\"]|\\{NL}|{ESCAPE})*\"
STRING2     = \'([^\n\r\f\\']|\\{NL}|{ESCAPE})*\'
BADSTRING1  = \"([^\n\r\f\\"]|\\{NL}|{ESCAPE})*\\?
BADSTRING2  = \'([^\n\r\f\\']|\\{NL}|{ESCAPE})*\\?
BADCOMMENT1 = \/\*[^*]*\*+([^/*][^*]*\*+)*
BADCOMMENT2 = \/\*[^*]*(\*+[^/*][^*]*)*
BADURI1     = url\({W}([!#$%&*-\[\]-~]|{NONASCII}|{ESCAPE})*{W}
BADURI2     = url\({W}{STRING}{W}
BADURI3     = url\({W}{BADSTRING}
COMMENT     = \/\*[^*]*\*+([^/*][^*]*\*+)*\/
IDENT       = -?{NMSTART}{NMCHAR}*
NAME        = {NMCHAR}+
NUM         = ([0-9]+|[0-9]*\.[0-9]+)
STRING      = ({STRING1}|{STRING2})
BADSTRING   = ({BADSTRING1}|{BADSTRING2})
BADCOMMENT  = ({BADCOMMENT1}|{BADCOMMENT2})
BADURI      = ({BADURI1}|{BADURI2}|{BADURI3})
URL         = ([!#$%&*-~]|{NONASCII}|{ESCAPE})*
S           = [\s\t\r\n\f]+
W           = {S}?
NL          = \n|\r\n|\r|\f

A_CHAR = a|\\0{0,4}(41|61)(\r\n|[\s\t\r\n\f])?
C_CHAR = c|\\0{0,4}(43|63)(\r\n|[\s\t\r\n\f])?
D_CHAR = d|\\0{0,4}(44|64)(\r\n|[\s\t\r\n\f])?
E_CHAR = e|\\0{0,4}(45|65)(\r\n|[\s\t\r\n\f])?
G_CHAR = g|\\0{0,4}(47|67)(\r\n|[\s\t\r\n\f])?|\\g
H_CHAR = h|\\0{0,4}(48|68)(\r\n|[\s\t\r\n\f])?|\\h
I_CHAR = i|\\0{0,4}(49|69)(\r\n|[\s\t\r\n\f])?|\\i
K_CHAR = k|\\0{0,4}(4b|6b)(\r\n|[\s\t\r\n\f])?|\\k
L_CHAR = l|\\0{0,4}(4c|6c)(\r\n|[\s\t\r\n\f])?|\\l
M_CHAR = m|\\0{0,4}(4d|6d)(\r\n|[\s\t\r\n\f])?|\\m
N_CHAR = n|\\0{0,4}(4e|6e)(\r\n|[\s\t\r\n\f])?|\\n
O_CHAR = o|\\0{0,4}(4f|6f)(\r\n|[\s\t\r\n\f])?|\\o
P_CHAR = p|\\0{0,4}(50|70)(\r\n|[\s\t\r\n\f])?|\\p
R_CHAR = r|\\0{0,4}(52|72)(\r\n|[\s\t\r\n\f])?|\\r
S_CHAR = s|\\0{0,4}(53|73)(\r\n|[\s\t\r\n\f])?|\\s
T_CHAR = t|\\0{0,4}(54|74)(\r\n|[\s\t\r\n\f])?|\\t
U_CHAR = u|\\0{0,4}(55|75)(\r\n|[\s\t\r\n\f])?|\\u
X_CHAR = x|\\0{0,4}(58|78)(\r\n|[\s\t\r\n\f])?|\\x
Z_CHAR = z|\\0{0,4}(5a|7a)(\r\n|[\s\t\r\n\f])?|\\z

Rules.

{S} : {token, {s, TokenLine, TokenChars}}.

\/\*[^*]*\*+([^/*][^*]*\*+)*\/ : skip_token.
{BADCOMMENT} : skip_token.

<!-- : {token, {cdo, TokenLine}}.
--> : {token, {cdc, TokenLine}}.
~= : {token, {includes, TokenLine}}.
\|= : {token, {dashmatch, TokenLine}}.

{STRING} : {token, {string, TokenLine, TokenChars}}.
{BADSTRING} : {token, {bad_string, TokenLine, TokenChars}}.

{IDENT} : {token, {ident, TokenLine, TokenChars}}.

#{NAME} : {token, {hash, TokenLine, TokenChars}}.

@{I_CHAR}{M_CHAR}{P_CHAR}{O_CHAR}{R_CHAR}{T_CHAR} : {token, {import_sym, TokenLine, TokenChars}}.
@{P_CHAR}{A_CHAR}{G_CHAR}{E_CHAR} : {token, {page_sym, TokenLine, TokenChars}}.
@{M_CHAR}{E_CHAR}{D_CHAR}{I_CHAR}{A_CHAR} : {token, {media_sym, TokenLine, TokenChars}}.
@charset\s : {token, {charset_sym, TokenLine, TokenChars}}.

!({W}|{COMMENT})*{I_CHAR}{M_CHAR}{P_CHAR}{O_CHAR}{R_CHAR}{T_CHAR}{A_CHAR}{N_CHAR}{T_CHAR} : {token, {important_sym, TokenLine, TokenChars}}.

{NUM}{E_CHAR}{M_CHAR} : {token, {ems, TokenLine, TokenChars}}.
{NUM}{E_CHAR}{X_CHAR} : {token, {exs, TokenLine, TokenChars}}.
{NUM}{P_CHAR}{X_CHAR} : {token, {length, TokenLine, TokenChars}}.
{NUM}{C_CHAR}{M_CHAR} : {token, {length, TokenLine, TokenChars}}.
{NUM}{M_CHAR}{M_CHAR} : {token, {length, TokenLine, TokenChars}}.
{NUM}{I_CHAR}{N_CHAR} : {token, {length, TokenLine, TokenChars}}.
{NUM}{P_CHAR}{T_CHAR} : {token, {length, TokenLine, TokenChars}}.
{NUM}{P_CHAR}{C_CHAR} : {token, {length, TokenLine, TokenChars}}.
{NUM}{D_CHAR}{E_CHAR}{G_CHAR} : {token, {angle, TokenLine, TokenChars}}.
{NUM}{R_CHAR}{A_CHAR}{D_CHAR} : {token, {angle, TokenLine, TokenChars}}.
{NUM}{G_CHAR}{R_CHAR}{A_CHAR}{D_CHAR} : {token, {angle, TokenLine, TokenChars}}.
{NUM}{M_CHAR}{S_CHAR} : {token, {time, TokenLine, TokenChars}}.
{NUM}{S_CHAR} : {token, {time, TokenLine, TokenChars}}.
{NUM}{H_CHAR}{Z_CHAR} : {token, {freq, TokenLine, TokenChars}}.
{NUM}{K_CHAR}{H_CHAR}{Z_CHAR} : {token, {freq, TokenLine, TokenChars}}.
{NUM}{IDENT} : {token, {dimension, TokenLine, TokenChars}}.

{NUM}% : {token, {percentage, TokenLine, TokenChars}}.
{NUM} : {token, {number, TokenLine, TokenChars}}.

url\({W}{STRING}{W}\) : {token, {uri, TokenLine, TokenChars}}.
url\({W}{URL}{W}\) : {token, {uri, TokenLine, TokenChars}}.
{BADURI} : {token, {bad_uri, TokenLine, TokenChars}}.

{IDENT}\( : {token, {function, TokenLine, TokenChars}}.

. : {token, {list_to_atom(TokenChars), TokenLine}}.

Erlang code.

%% <Erlang code>