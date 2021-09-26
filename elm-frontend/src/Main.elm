port module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--

import Browser
import Challenges exposing (Challenge, ChallengeData, ChallengeEntry, Msg(..), getChallengeDetails, getChallenges, viewChallengeDetailsModal, viewChallengesGrid)
import Css
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onClick)
import Json.Encode exposing (Value)
import List
import Platform.Sub
import Svg.Styled.Attributes as Attr
import Tailwind.Utilities as Tw



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = Html.Styled.toUnstyled << view
        }



-- MODEL


type alias User =
    { username : String }


type alias Model =
    { challenges : List ChallengeData, count : Int, selected : Maybe ChallengeData }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { challenges = [], count = 1, selected = Nothing }
    , getChallenges
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


port jsonConsole : Json.Encode.Value -> Cmd msg



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        GotChallenge result ->
            case result of
                Err error ->
                    Debug.log (Debug.toString error)
                        ( { model | count = model.count + 1 }, Cmd.none )

                Ok newChallenges ->
                    Debug.log (Debug.toString newChallenges)
                        ( { model | challenges = model.challenges ++ List.map (\c -> Challenges.Just c) newChallenges }
                        , Cmd.none
                        )

        GotChallengeDetails result ->
            case result of
                Err error ->
                    Debug.log (Debug.toString error)
                        ( { model | count = model.count + 1 }, Cmd.none )

                Ok details ->
                    ( { model
                        | challenges =
                            List.map
                                (\c ->
                                    case c of
                                        Challenges.Just challenge ->
                                            if challenge.id == details.id then
                                                Challenges.WithEntries ( challenge, details.entries )

                                            else
                                                c

                                        Challenges.WithEntries ( challenge, _ ) ->
                                            if challenge.id == details.id then
                                                Challenges.WithEntries ( challenge, details.entries )

                                            else
                                                c
                                )
                                model.challenges
                      }
                    , Cmd.none
                    )

        LoadChallengeDetails challenge ->
            ( model
            , Cmd.map
                (\r ->
                    case r of
                        Challenges.GotChallengeEntries details ->
                            GotChallengeDetails (Result.map (\res -> { id = challenge.id, entries = res }) details)
                )
                (getChallengeDetails challenge)
            )

        ShowChallengeDetails maybeDetails ->
            case model.selected of
                Just a ->
                    Debug.log "deselected "
                        ( { model | selected = Nothing }, Cmd.none )

                Nothing ->
                    Debug.log ("clicked " ++ Debug.toString maybeDetails)
                        ( { model | selected = maybeDetails }, Cmd.none )



-- VIEW


viewCounter : Model -> Html Msg
viewCounter model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model.count) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


viewHeader : Html Msg
viewHeader =
    div [ Attr.css [ Tw.flex_col, Tw.items_center, Tw.bg_red_100 ] ]
        [ div [ Attr.css [ Tw.text_2xl, Tw.text_center, Tw.py_5 ] ] [ text "Rivalize" ]
        ]


view : Model -> Html Msg
view model =
    div [ Attr.css [], Attr.style "margin: -8;" ]
        [ viewChallengeDetailsModal model.selected
        , div [] [ viewHeader ]
        , div [ Attr.css [ Tw.p_5 ] ] [ viewChallengesGrid model.challenges ]
        ]
