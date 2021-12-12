
class Configure{
    public String fileImg;  
    public PVector showImgOffset; 

    public int pixelRatioMove;  
    public float accelerationSet; 
    public int waitUpdate;
    public int numUpdateOnce;
    Configure(){
        Setting();
    }
    
    public void Setting(){
        fileImg = "./img/img-1.png";  
        
        showImgOffset = new PVector( 0, -30 ); 
        pixelRatioMove = 5;  
        accelerationSet = 0.1; 
        waitUpdate = 10; 
        numUpdateOnce = 500;   
    }
    
    
    
}
