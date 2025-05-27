package com.share.device.controller;

import com.share.common.core.web.controller.BaseController;
import com.share.common.core.web.domain.AjaxResult;
import com.share.common.core.web.page.TableDataInfo;
import com.share.device.domain.Station;
import com.share.device.service.IStationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "站点接口管理")
@RestController
@RequestMapping("/station")
public class StationController extends BaseController {

    @Autowired
    private IStationService stationService;

    //分页查询
    @Operation(summary = "查询站点列表")
    @GetMapping("/list")
    public TableDataInfo list(Station station) {
        //设置分页参数
        startPage();
        //查询
        List<Station> list = stationService.selectStationList(station);
        TableDataInfo tableDataInfo = getDataTable(list);
        return tableDataInfo;
    }

    //添加
    @Operation(summary = "新增站点")
    @PostMapping
    public AjaxResult add(@RequestBody Station station) {
        return toAjax(stationService.saveStation(station));
    }

    //修改
    @Operation(summary = "修改站点")
    @PutMapping
    public AjaxResult edit(@RequestBody Station station) {
        return toAjax(stationService.updateStation(station));
    }




}
