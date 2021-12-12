
class PixelMatrix{
    
    public PixelOne[][] pixelArray; 
    public boolean[][] pixelsUpdate; 
    private PVector pointsStart;  
    private int pixelRatioShow;  
    PixelMatrix(){
        
    }


    public void IniPixelMatrix( Configure tConfs ){
        pixelRatioShow = 1;
        PImage tImage = loadImage( tConfs.fileImg );
        tImage.loadPixels();
        IniPixels( new PVector(tImage.width,tImage.height), tConfs.showImgOffset, tConfs.pixelRatioMove, tConfs.accelerationSet, tImage.pixels  );
    }

    public void IniPixels( PVector tSideLength, PVector tShowOffset, int tSizeRatioMove, float tAccelerationSet, color[] tColors ){
        PVector tPoint = new PVector( 0, 0 );
        pointsStart = new PVector( int(width/2-(tSideLength.x*pixelRatioShow)/2+tShowOffset.x), int(height/2+tShowOffset.y) );
        pixelArray = new PixelOne[int(tSideLength.y)][int(tSideLength.x)];
        pixelsUpdate = new boolean[int(tSideLength.y)][int(tSideLength.x)];
        for( int y=0; y<tSideLength.y; y++ ){
            tPoint.y = pointsStart.y + y*pixelRatioShow;
            for( int x=0; x<tSideLength.x; x++ ){
                tPoint.x = pointsStart.x + x*pixelRatioShow;
                pixelArray[y][x] = new PixelOne( tPoint, new PVector[]{new PVector(tSizeRatioMove,tSizeRatioMove),new PVector(pixelRatioShow,pixelRatioShow)}, tAccelerationSet );
                pixelArray[y][x].SetColors( tColors[int(y*tSideLength.x+x)], 255,tColors[int(y*tSideLength.x+x)], 255 );
                pixelsUpdate[y][x] = false;
            }
        }
        
    }
    
    public void SetUpdateEnable( int tX, int tY ){
        pixelsUpdate[tY][tX] = true;
    }

    public void SetUpdateEnable(){
        for( int y=0; y<pixelsUpdate.length; y++ ){
            for( int x=0; x<pixelsUpdate[y].length; x++ ){
                SetUpdateEnable( x, y );
            }
        }
    }
    
    public ArrayList<PVector> Update(){
        ArrayList<PVector> tOuts = new ArrayList<PVector>();
        for( int y=0; y<pixelArray.length; y++ ){
            for( int x=0; x<pixelArray[y].length; x++ ){
                if( pixelsUpdate[y][x] == true ){
                    if( pixelArray[y][x].Update() == 1 ){
                        tOuts.add( new PVector( x, y, pixelArray[y][x].GetColorNow() ) );
                    }
                }
            }
        }
        return tOuts;
    }
    

    public void PointsGotoStart(){
        for( int y=0; y<pixelArray.length; y++ ){
            for( int x=0; x<pixelArray[y].length; x++ ){
                pixelArray[y][x].SetPointGoto( new PVector( int(random(0,width)), 0 ) );
                
            }
        }
    }

    public void SetPointsTarget(){
        for( int y=0; y<pixelArray.length; y++ ){
            for( int x=0; x<pixelArray[y].length; x++ ){
                pixelArray[y][x].SetPointTarget( pixelArray[y][x].pointImg, true );
            }
        }
    }

    public void SetAcceleration( float tAcceleration ){
        for( int y=0; y<pixelArray.length; y++ ){
            for( int x=0; x<pixelArray[y].length; x++ ){
                pixelArray[y][x].SetAcceleration( tAcceleration );
            }
        }
    }
    
    public PVector GetMatrixSize(){
        return new PVector( pixelArray[0].length, pixelArray.length );
    }

    public PVector GetShowStart(){
        return pointsStart;
    }
    
    
}
