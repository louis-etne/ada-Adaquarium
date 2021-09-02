with Ada.Containers.Vectors;
with Ada.Numerics.Float_Random;

with Fish; use Fish;
with Seaweed; use Seaweed;


package Aquarium is

    type Aquarium_Type is tagged private;

    procedure Init;

    procedure Next_Day (Aquarium : in out Aquarium_Type);

    procedure Add_Fish 
        (Aquarium : in out Aquarium_Type;
         Name     : in     String;
         Gender   : in     Gender_Type;
         Species  : in     Species_Type);

    procedure Add_Seaweed
        (Aquarium : in out Aquarium_Type;
         Count    : in     Positive := Positive'First);

    procedure Display (Aquarium : in Aquarium_Type);

private

    package Fish_Vectors is new Ada.Containers.Vectors
        (Index_Type   => Positive,
         Element_Type => Fish_Type);

    package Seaweed_Vectors is new Ada.Containers.Vectors
        (Index_Type   => Positive,
         Element_Type => Seaweed_Type);

    package Random renames Ada.Numerics.Float_Random;

    Generator : Random.Generator;

    type Aquarium_Type is tagged record
        Age : Natural := Natural'First;
        Fishes : Fish_Vectors.Vector;
        Seaweeds : Seaweed_Vectors.Vector;
    end record;

end Aquarium;