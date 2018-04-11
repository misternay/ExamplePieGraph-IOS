import UIKit
import Charts

class ViewController: UIViewController ,ChartViewDelegate{
    
    //MARK:- OUTLET
    @IBOutlet weak var pieChart: PieChartView!
    @IBAction func onRandomBtnPress(_ sender: Any) {
        prepareChart()
    }
    
    //MARK:- DATA
    let fruits = ["apple", "banana", "cherry", "dragonfruit", "elderberry", "fig"]


    override func viewDidLoad() {
        super.viewDidLoad()
        prepareChart()
        pieChart.delegate = self
    }
    
    func prepareChart(){
        setupData(5, range: 100)
        pieChart.chartDescription?.text = "" //SET DESCRIPTION LABEL = NULL
        pieChart.legend.enabled = true //SET LEGEND
        setupLegend()
        pieChart.highlightValues(nil)
    }
    
    func setupLegend(){
        let pieLegend = pieChart.legend
        pieLegend.horizontalAlignment = .center
        pieLegend.verticalAlignment = .bottom
        pieLegend.orientation = .horizontal
        pieLegend.xEntrySpace = 7
        pieLegend.yEntrySpace = 10
        pieLegend.yOffset = -1
        pieLegend.direction = .leftToRight
        pieLegend.form = .circle
        pieLegend.font = UIFont(name: "Didot", size: 15)!
    }
    
    func genEntity(_ count: Int, range: UInt32) -> [PieChartDataEntry]{
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: fruits[i % fruits.count])
        }
        return entries
    }
    
    func setPieDataSet(entries: [PieChartDataEntry]) -> PieChartDataSet{
        let set = PieChartDataSet(values: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 0
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        return set
    }
    
    func setupFormatter() -> NumberFormatter{
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        return pFormatter
    }
    
    func setPieData(dataSet: PieChartDataSet){
        let pFormatter = setupFormatter()
        let data = PieChartData(dataSet: dataSet)
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 20, weight: .light))
        data.setValueTextColor(NSUIColor.darkGray)
        pieChart.data = data
    }
    
    func setupData(_ count: Int, range: UInt32) {
        let entries = genEntity(count, range: range)
        let dataSet = setPieDataSet(entries: entries)
        setPieData(dataSet: dataSet)
    }
}

