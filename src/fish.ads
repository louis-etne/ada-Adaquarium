with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Living; use Living;


package Fish is

    type Gender_Type is (Female, Male);

    type Diet_Type is (Herbivorous, Carnivorous);

    type Species_Type is (Grouper, Tuna, Clownfish, Sole, Seabass, Carp);
    subtype Herbivorous_Species is Species_Type range Sole .. Carp;
    subtype Carnivorous_Species is Species_Type range Grouper .. Tuna;

    type Sexuality_Type is (Monosexual, Age_Hermaphrodite, Opportunistic_Hermaphrodite);
    subtype Monosexual_Species is Species_Type
        with Static_Predicate => Monosexual_Species in Carp | Tuna;
    subtype Age_Hermaphrodite_Species is Species_Type 
        with Static_Predicate => Age_Hermaphrodite_Species in Seabass | Grouper;
    subtype Opportunistic_Hermaphrodite_Species is Species_Type
        with Static_Predicate => Opportunistic_Hermaphrodite_Species in Sole | Clownfish;

    type Fish_Type is new Living_Type with private;

    function Create
        (Name    : String;
         Gender  : Gender_Type;
         Species : Species_Type;
         Health  : Natural := 10)
        return Fish_Type;

    function Species (Fish : Fish_Type) return Species_Type;
    function Gender (Fish : Fish_Type) return Gender_Type;
    function Diet (Fish : Fish_Type) return Diet_Type;
    function Sexuality (Fish : Fish_Type) return Sexuality_Type;

    function Is_Hungry (Fish : Fish_Type) return Boolean;
    
    Overriding
    function Can_Reproduce (Fish : Fish_Type) return Boolean;
    function Will_Bang (Fish, Partner : Fish_Type) return boolean;

    procedure Eat (Fish : in out Fish_Type; Living : in out Living_Type'Class);

    function Image (Gender : Gender_Type) return String;
    function Image (Diet : Diet_Type) return String;
    function Image (Species : Species_Type) return String;
    function Image (Fish : Fish_Type) return String;

private

    type Fish_Type is new Living_Type with record
        Name    : Unbounded_String;
        Gender  : Gender_Type;
        Species : Species_Type;
    end record;

end Fish;