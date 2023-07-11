import UIKit
import Charts

class ChartVC: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    
//    private let categoryViewmodel = CategoryViewModel()
//    private let subCategoryViewModel = SubCategoryViewModel()
    private let movimientoViewModel = MovimientoViewModel()
    let idUsuario = UserDefaults.standard.integer(forKey: "idUsuario")
    private var totales: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entitries = [ChartDataEntry]()
        
        for x in 0..<10{
            entitries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = PieChartDataSet(entries: entitries)
        set.colors = ChartColorTemplates.pastel()
        
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
    
    func loadMovimiento(){
        let result = movimientoViewModel.GetAllByUser(idUser: idUsuario)
        if result.Correct{
            let model = result.Objects as! [Movimiento]
        }else{
            
        }
    }
    
}
