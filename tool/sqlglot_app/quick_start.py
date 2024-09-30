from icecream import ic

ic.configureOutput(includeContext=True, argToStringFunction=str)
ic.lineWrapWidth = 120

from sqlglot import parse_one, exp

# print all column references (a and b)
for column in parse_one(
    "SELECT a, b + 1 AS c FROM d WHERE a = 'name'", dialect="mysql"
).find_all(exp.Column):
    ic(column.alias_or_name)

# find all projections in select statements (a and c)
for select in parse_one("SELECT a, b + 1 AS c FROM d", dialect="mysql").find_all(
    exp.Select
):
    for projection in select.expressions:
        ic(projection.alias_or_name)

# find all tables (x, y, z)
for table in parse_one("SELECT * FROM x JOIN y JOIN z", dialect="mysql").find_all(
    exp.Table
):
    ic(table.name)

sql = "SELECT a, b + 1 AS c FROM d WHERE a = 'name'"
ast = parse_one(sql)
ic(sql, repr(ast))
ic(ast.args["expressions"][1])

ast = parse_one(
    """
SELECT * FROM (SELECT a, b FROM x)
"""
)
#    ast.args["from"].this: (SELECT a, b FROM x)
#    ast.args["from"].this.this: SELECT a, b FROM x
ic(ast.args["from"].this, ast.args["from"].this.this)
# To modify the AST in-place, set `copy=False`
ast.args["from"].this.this.select("c", copy=False)

ic(ast)
# SELECT * FROM (SELECT a, b, c FROM x)

ast = parse_one(
    """
SELECT * FROM (SELECT a, b FROM x)
"""
)

# To modify the AST in-place, set `copy=False`
ast2 = ast.args["from"].this.this.select("c", copy=True)
# ast: SELECT * FROM (SELECT a, b FROM x), ast2: SELECT a, b, c FROM x
ic(ast, ast2)

