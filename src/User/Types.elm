module User.Types exposing (..)


type alias Model =
    { id : Int
    , username : String
    , name : String
    , email : String
    , url : String
    }


type Msg
    = NoOp
