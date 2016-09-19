module Type exposing (..)

import Cadastro.Type as Cadastro


type alias Model =
    { cadastro : Cadastro.Model
    , logic : Int
    }


type Msg
    = CadastroMsg Cadastro.Msg
