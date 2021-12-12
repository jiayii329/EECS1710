
public Main main;  

public void settings() {
    size(600, 500);
}


public void setup(){
    main = new Main();
    main.Ready();
    
}

public void draw(){
    background(255);
    main.Run();
}
