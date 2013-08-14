open Camlp4

module Id : Sig.Id = struct 
  let name = "where" 
  let version = "0.1" 
end 

module Make (Syntax : Sig.Camlp4Syntax) = struct
  open Sig
  include Syntax

    EXTEND Gram
      expr: BEFORE ":="
        [ "where"
          [ e = SELF; "where"; rf = opt_rec; lb = let_binding ->
            <:expr< let $rec:rf$ $lb$ in $e$ >> ]
        ];
    END
end
  
module M = Register.OCamlSyntaxExtension(Id)(Make)
