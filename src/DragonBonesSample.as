package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;
    
    import dragonBones.factorys.StarlingFactory;
    import dragonBones.objects.AnimationData;
    import dragonBones.objects.ArmatureData;
    import dragonBones.objects.BoneData;
    import dragonBones.objects.DBTransform;
    import dragonBones.objects.DisplayData;
    import dragonBones.objects.EllipseData;
    import dragonBones.objects.Frame;
    import dragonBones.objects.FrameCached;
    import dragonBones.objects.IAreaData;
    import dragonBones.objects.RectangleData;
    import dragonBones.objects.SkeletonData;
    import dragonBones.objects.SkinData;
    import dragonBones.objects.SlotData;
    import dragonBones.objects.Timeline;
    import dragonBones.objects.TimelineCached;
    import dragonBones.objects.TransformFrame;
    import dragonBones.objects.TransformTimeline;
    
    import starling.core.Starling;
    import starling.events.Event;
    
    public class DragonBonesSample extends Sprite
    {
        public function DragonBonesSample()
        {
            super();
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.frameRate = 60;
            
            Starling.multitouchEnabled = true;
            Starling.handleLostContext = true;
            var mStarling:Starling = new Starling(Game, stage);
            mStarling.simulateMultitouch  = false;
            mStarling.enableErrorChecking = false;
            
            mStarling.start();
            mStarling.addEventListener(Event.ROOT_CREATED, onRootCreated);
        }
        
        private function onRootCreated(event:Event, game:Game):void
        {
            loadDBTest();
        }
        
        [Embed(source="data.dbpng", mimeType="application/octet-stream")]
        public static const catBinaryClass:Class;
        private var skeltonData:SkeletonData;
        private var byteArray:ByteArray;
        
        private function loadDBTest():void {
            var factory:StarlingFactory = new StarlingFactory();
            var catBinary:ByteArray = new catBinaryClass() as ByteArray;
            var st:int = getTimer();
            skeltonData = factory.parseData(catBinary);
            var et:int = getTimer();
            trace("parse done1 time : "+ (et-st)+" ms");
            
            registerClassAlias("String", String);
            registerClassAlias("flash.geom.ColorTransform", ColorTransform);
            registerClassAlias("flash.geom.Point", Point);
            registerClassAlias("flash.geom.Matrix", Matrix);
            registerClassAlias("dragonBones.objects.SkeletonData", SkeletonData);
            registerClassAlias("dragonBones.objects.ArmatureData", ArmatureData);
            registerClassAlias("dragonBones.objects.BoneData", BoneData);
            registerClassAlias("dragonBones.objects.SkinData", SkinData);
            registerClassAlias("dragonBones.objects.SlotData", SlotData);
            registerClassAlias("dragonBones.objects.DisplayData", DisplayData);
            registerClassAlias("dragonBones.objects.RectangleData", RectangleData);
            registerClassAlias("dragonBones.objects.EllipseData", EllipseData);
            registerClassAlias("dragonBones.objects.AnimationData", AnimationData);
            registerClassAlias("dragonBones.objects.TransformTimeline", TransformTimeline);
            registerClassAlias("dragonBones.objects.Timeline", Timeline);
            registerClassAlias("dragonBones.objects.TimelineCached", TimelineCached);
            registerClassAlias("dragonBones.objects.Frame", Frame);
            registerClassAlias("dragonBones.objects.TransformFrame", TransformFrame);
            registerClassAlias("dragonBones.objects.FrameCached", FrameCached);
            registerClassAlias("dragonBones.objects.DBTransform", DBTransform);
            registerClassAlias("dragonBones.objects.IAreaData", IAreaData);
            
            byteArray = new ByteArray();
            byteArray.writeObject(skeltonData);
            byteArray.position = 0;
            setTimeout(readObj, 1000);
        }
        
        private function readObj():void {
            var st:int = getTimer();
            var skeltonData2:SkeletonData = byteArray.readObject();
            var et:int = getTimer();
            trace("parse done2 time : "+ (et-st)+" ms");
            trace("2 : " + skeltonData2);
        }
    }
}