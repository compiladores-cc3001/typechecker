{-
  Abstract Syntax Trees for a simple imperative language
  Pedro Vasconcelos, 2022-2023
-}
module AST where

-- identiifers
type Ident = String

--- types
data Type = TyInt              -- integers
          | TyBool             -- booleans
          | TyFun [Type] Type  -- functions
          deriving (Show, Eq)

--- expressions
data Expr = Var Ident             -- x, y, z
          | Num Int               -- 1, 2, 3
          | Add Expr Expr         -- e1 + e2
          | LessThan Expr Expr    -- e1 < e2
          | FunCall Ident [Expr]  -- f(e1,e2,...)
          deriving Show

--- statements
data Stm = Assign Ident Expr        -- var = expr
         | IfThenElse Expr Stm Stm  -- if (cond) stm1 else stm2
         | IfThen Expr Stm          -- if (cond) stm
         | While Expr Stm           -- while (cond) stm
         | Block [Decl] [Stm]       -- { decls; stms }
         | Return Expr              -- return expr
         deriving Show

--- variable declarations
type Decl = (Ident, Type)           -- variable, type

--- function declarations
data FunDef
  = FunDef Ident [(Ident,Type)] Type Stm  
  deriving Show

--- complete programs
data Prog = Prog [FunDef] Stm
  deriving Show

