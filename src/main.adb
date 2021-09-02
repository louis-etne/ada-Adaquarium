with Aquarium; use Aquarium;
with Fish; use Fish;

procedure Main is
    A : Aquarium_Type;
begin
    Init;

    A.Add_Fish ("G1", Male, Grouper);
    A.Add_Fish ("G2", Female, Grouper);
    
    A.Add_Fish ("T1", Male, Tuna);
    A.Add_Fish ("T2", Female, Tuna);

    A.Add_Fish ("CF1", Male, Clownfish);
    A.Add_Fish ("CF2", Female, Clownfish);

    A.Add_Fish ("SO1", Male, Sole);
    A.Add_Fish ("SO2", Female, Sole);

    A.Add_Fish ("SB1", Male, Seabass);
    A.Add_Fish ("SB2", Female, Seabass);

    A.Add_Fish ("CP1", Male, Carp);
    A.Add_Fish ("CP2", Female, Carp);

    A.Add_Seaweed (3);

    for I in 1 .. 30 loop
        A.Display;
        A.Next_Day;
    end loop;

end Main;