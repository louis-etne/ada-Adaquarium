with Ada.Text_IO; use Ada.Text_IO;

package body Aquarium is
    use Ada.Containers;

    procedure Init is
    begin
        Random.Reset (Generator);
    end Init;

    procedure Next_Day (Aquarium : in out Aquarium_Type) is
        package Index_Vectors is new Ada.Containers.Vectors
            (Index_Type   => Positive,
             Element_Type => Positive);

        S : Seaweed_Vectors.Vector renames Aquarium.Seaweeds;
        F : Fish_Vectors.Vector renames Aquarium.Fishes;

        New_Seaweeds : Seaweed_Vectors.Vector;
        New_Fishes : Fish_Vectors.Vector;

        procedure Clear_Deads is
        begin
            for I in reverse S.First_Index .. S.Last_Index loop
                if not S (I).Is_Alive then
                    S.Delete (I);
                end if;
            end loop;

            for I in reverse F.First_Index .. F.Last_Index loop
                if not F (I).Is_Alive then
                    F.Delete (I);
                end if;
            end loop;
        end Clear_Deads;

        function Random_Index (Max : Positive) return Positive is
        begin
            return Positive (1 + Natural (Random.Random (Generator) * Float (Max - 1)));
        end Random_Index;

        procedure Handle_Launch_For_Index (I : Positive) is
            Edible : Index_Vectors.Vector;
        begin
            case F (I).Diet is
                when Carnivorous =>
                    for J in F.First_Index .. F.Last_Index loop
                        if I /= J and then F (I).Species /= F (J).Species and then F (J).Is_Alive then
                            Edible.Append (J);
                        end if;
                    end loop;

                    if Edible.Length > Count_Type'First then
                        F (I).Eat (F.Reference (Edible (Random_Index (Edible.Last_Index))));
                    end if;
                when Herbivorous =>
                    for J in S.First_Index .. S.Last_Index loop
                        if S (J).Is_Alive then
                            Edible.Append (J);
                        end if;
                    end loop;

                    if Edible.Length > Count_Type'First then
                        F (I).Eat (S.Reference (Edible (Random_Index (Edible.Last_Index))));
                    end if;
            end case;
        end Handle_Launch_For_Index;

        procedure Handle_Sex_For_Index (I : Positive) is
            Possible_Mates : Index_Vectors.Vector;
            G : Gender_Type;
        begin
            for J in F.First_Index .. F.Last_Index loop
                if I /= J and then F (J).Is_Alive then
                    Possible_Mates.Append (J);
                end if;
            end loop;

            if Possible_Mates.Length > Count_Type'First then
                if F (I).Will_Bang (F.Reference (Possible_Mates (Random_Index (Possible_Mates.Last_Index)))) then
                    if Random_Index (2) mod 2 = 0 then
                        G := Female;
                    else
                        G := Male;
                    end if;

                    New_Fishes.Append (Create ("Baby", G, F (I).Species, 5));
                end if;
            end if;
        end Handle_Sex_For_Index;

    begin
        Clear_Deads;
        New_Seaweeds.Clear;
        New_Fishes.Clear;

        for Seaweed of S loop
            Seaweed.Grow;

            if Seaweed.Can_Reproduce then
                New_Seaweeds.append (Create (Seaweed.Health - Seaweed.Health / 2));
                Seaweed.Lose_Health (Seaweed.Health / 2);
            end if;
        end loop;

        for Seaweed of New_Seaweeds loop
            S.Append (Seaweed);
        end loop;

        for I in F.First_Index .. F.Last_Index loop
            F (I).Lose_Health (1);

            if F (I).Is_Alive then
                if F (I).Is_Hungry then
                    Handle_Launch_For_Index (I);
                elsif F (I).Can_Reproduce then
                    Handle_Sex_For_Index (I);
                end if;
                
                F (I).Increment_Age;
            end if;
        end loop;

        for Fish of New_Fishes loop
            F.Append (Fish);
        end loop;

        Aquarium.Age := @ + 1;
    end Next_Day;

    procedure Add_Fish 
        (Aquarium : in out Aquarium_Type;
         Name     : in     String;
         Gender   : in     Gender_Type;
         Species  : in     Species_Type) 
    is
        Fish : constant Fish_Type := Create (Name, Gender, Species);
    begin
        Aquarium.Fishes.Append (Fish);
    end Add_Fish;

    procedure Add_Seaweed 
        (Aquarium : in out Aquarium_Type;
         Count    : in     Positive := Positive'First)
    is
        Seaweed : constant Seaweed_Type := Create;
    begin
        for I in 1 .. Count loop
            Aquarium.Seaweeds.Append (Seaweed);
        end loop;
    end Add_Seaweed;

    procedure Display (Aquarium : in Aquarium_Type) is
    begin
        Put_Line ("_____________________________________________________________");
        Put_Line ("Aquarium age :" & Aquarium.Age'Img);
        Put_Line ("Aquarium contains " & Aquarium.Fishes.Length'Img & " fishes and" & Aquarium.Seaweeds.Length'Img & " seaweeds.");

        if Aquarium.Fishes.Length > Count_Type'First then
            Put_Line ("Fishes:");

            for Fish of Aquarium.Fishes loop
                Put_Line ("  - " & Fish.Image);
            end loop;
        end if;

        if Aquarium.Seaweeds.Length > Count_Type'First then
            Put_Line ("Seaweeds:");

            for Seaweed of Aquarium.Seaweeds loop
                Put_Line ("  - " & Seaweed.Image);
            end loop;
        end if;

        Put_Line ("_____________________________________________________________");
    end Display;

end Aquarium;