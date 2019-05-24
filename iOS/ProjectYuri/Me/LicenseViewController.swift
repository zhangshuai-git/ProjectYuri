//
//  LicenseViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/25.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class LicenseViewController: ZSViewController {
    
    lazy var sectionedDataSource: Observable<[SectionModel<String, String>]> = Observable.of([
        SectionModel(model: "", items: ["""
            ZSUtils

            Copyright (c) 2019 艾露猫 - https://github.com/moemipa/ZSUtils

            Permission is hereby granted, free of charge, to any person obtaining a copy\
            of this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is\
            furnished to do so, subject to the following conditions:

            The above copyright notice and this permission notice shall be included in all\
            copies or substantial portions of the Software.

            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\
            SOFTWARE.
            """]),
        SectionModel(model: "", items: ["""
            SnapKit

            Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit

            Permission is hereby granted, free of charge, to any person obtaining a copy\
            of this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is\
            furnished to do so, subject to the following conditions:

            The above copyright notice and this permission notice shall be included in\
            all copies or substantial portions of the Software.

            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\
            THE SOFTWARE.
            """]),
        SectionModel(model: "", items: ["""
            MJRefresh

            Copyright (c) 2013-2015 MJRefresh (https://github.com/CoderMJLee/MJRefresh)
            
            Permission is hereby granted, free of charge, to any person obtaining a copy\
            of this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is\
            furnished to do so, subject to the following conditions:
            
            The above copyright notice and this permission notice shall be included in\
            all copies or substantial portions of the Software.
            
            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\
            THE SOFTWARE.
            """]),
        SectionModel(model: "", items: ["""
            RxSwift

            **The MIT License**
            **Copyright © 2015 Krunoslav Zaher**
            **All rights reserved.**

            Permission is hereby granted, free of charge, to any person obtaining a copy of\
            this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is furnished\
            to do so, subject to the following conditions:

            The above copyright notice and this permission notice shall be included in all\
            copies or substantial portions of the Software.

            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL\
            THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING\
            FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS\
            IN THE SOFTWARE.
            """]),
        SectionModel(model: "", items: ["""
            Alamofire

            Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)

            Permission is hereby granted, free of charge, to any person obtaining a copy\
            of this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is\
            furnished to do so, subject to the following conditions:

            The above copyright notice and this permission notice shall be included in\
            all copies or substantial portions of the Software.

            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\
            THE SOFTWARE.
            """]),
        SectionModel(model: "", items: ["""
            HandyJSON

            Copyright 1999-2016  Alibaba Group Holding Ltd.
            
            Licensed under the Apache License, Version 2.0 (the "License");\
            you may not use this file except in compliance with the License.\
            You may obtain a copy of the License at
            
            http://www.apache.org/licenses/LICENSE-2.0
            
            Unless required by applicable law or agreed to in writing, software\
            distributed under the License is distributed on an "AS IS" BASIS,\
            WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\
            See the License for the specific language governing permissions and\
            limitations under the License.
            """]),
        SectionModel(model: "", items: ["""
            SDWebImage

            Copyright (c) 2009-2017 Olivier Poitrey rs@dailymotion.com
            
            Permission is hereby granted, free of charge, to any person obtaining a copy\
            of this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is furnished\
            to do so, subject to the following conditions:
            
            The above copyright notice and this permission notice shall be included in all\
            copies or substantial portions of the Software.
            
            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\
            THE SOFTWARE.
            """]),
        SectionModel(model: "", items: ["""
            SVProgressHUD

            Copyright (c) 2011-2018 Sam Vermette, Tobias Tiemerding and contributors.

            Permission is hereby granted, free of charge, to any person obtaining a copy\
            of this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is\
            furnished to do so, subject to the following conditions:

            The above copyright notice and this permission notice shall be included in all\
            copies or substantial portions of the Software.

            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\
            SOFTWARE.
            """]),
        SectionModel(model: "", items: ["""
            SGPagingView

            Copyright (c) 2016 kingsic

            Permission is hereby granted, free of charge, to any person obtaining a copy\
            of this software and associated documentation files (the "Software"), to deal\
            in the Software without restriction, including without limitation the rights\
            to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\
            copies of the Software, and to permit persons to whom the Software is\
            furnished to do so, subject to the following conditions:

            The above copyright notice and this permission notice shall be included in all\
            copies or substantial portions of the Software.

            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\
            SOFTWARE.
            """]),
        ])
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(UITableViewCell.self)
        return tableView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(tableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        sectionedDataSource
            .bind(to: tableView.rx.items(dataSource: RxTableViewSectionedReloadDataSource(
                configureCell: { (dataSource, tableView, indexPath, element) in
                    let cell = tableView.zs.dequeueReusableCell(UITableViewCell.self, for: indexPath)
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
                    cell.textLabel?.text = element
                    return cell
                }
            )))
            .disposed(by: disposeBag)
    }
}

