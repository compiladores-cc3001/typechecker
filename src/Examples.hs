{-
  Some example terms for testing the typechecker
  Pedro Vasconcelos, 2023
-}
module Examples where

import AST

example1 :: Expr
example1 =
  LessThan (Num 42) (Add (Num 100) (Num 23))

example2 :: Expr
example2 =
  LessThan (Num 42) (Add (Var "x") (Num 23))

example3 :: Stm
example3 =
  Assign "x" (Add (Num 23) (Num 42))

example4 :: Stm
example4 =
  Block
    [("x", TyInt), ("y",TyInt)]
    [ Assign "x" (Num 42)
    , Assign "y" (LessThan (Var "x") (Num 77))
    , IfThen
      (LessThan (Var "x") (Var "y"))
      (Assign "y" (Var "x"))     
    ]

example5 :: Stm
example5 =
  Block [("x", TyInt), ("y",TyInt)]
  [ Assign "x" (Num 42)
  , Assign "x" (Num 77)
  , IfThen (Var "x" `LessThan` Var "y")
    (Block [("temp", TyInt)]
     [ Assign "temp" (Var "y")
     , Assign "y" (Var "x")
     , Assign "x" (Var "temp")
     ])
  ]

example6 :: FunDef
example6 =
  FunDef "f" [("x", TyInt)] TyInt
      (Return (Add (Var "x") (Num 1)))

example7 :: FunDef 
example7 =
  FunDef "g"
     [("x", TyInt)] TyInt
     (IfThenElse
      (LessThan (Var "x") (Num 0))
      (Return (Num 0))
      (Return (LessThan (Num 2)
               (FunCall "g" [Add (Var "x") (Num (-1))])))
     )

example8 :: Prog
example8
  = Prog [example6, example7]
    (Block [("x", TyInt)]
     [Assign "x" (Add (FunCall "f" [Num 3]) (FunCall "g" [Num 4]))])

