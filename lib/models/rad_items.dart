class RadiationCalculatorItems{
  double? distanceFromSource;
  double? workingDistance;
  double? readingFromPoint;
  double? transportIndex;
  double? radiationSource = 0;
  double? radiationOnWork = 0;
  double? actingForRisk100 = 0;
  double? actingForRisk250 = 0;
  double? safeRadiationSource = 0;
  double? safeRadiationOnSite = 0;
  double? safeForRisk100 = 0;
  double? safeForRisk250 = 0;

  RadiationCalculatorItems({this.distanceFromSource =0 , this.readingFromPoint=0,this.transportIndex=0,this.workingDistance=0}
  );
  get radItems{
    return RadiationCalculatorItems();
  }
}