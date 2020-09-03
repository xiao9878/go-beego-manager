package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/disk"
	"github.com/shirou/gopsutil/mem"
	"manager/common"
	"os"
	"runtime"
	"strconv"
	"time"
)

type SysInfo struct {
	beego.Controller
}

type Info struct {
	Name    string                 `json:"host"`
	Os      string                 `json:"os"`
	Adl     string                 `json:"adl"`
	CoreNum int                    `json:"coreNum"`
	Version string                 `json:"version"`
	Cpu     map[string]interface{} `json:"cpu"`
	Memory  map[string]string      `json:"memory"`
	Disk    map[string]string      `json:"disk"`
}

// @router /sys/info [get]
func (this *SysInfo) GetInfo() {
	s := time.Now().Nanosecond()
	cpu, _ := cpu.Info()
	memory, _ := mem.VirtualMemory()
	disk, _ := disk.Usage("D:")
	cpuInfo := map[string]interface{}{
		"name":  cpu[0].ModelName,
		"mhz":   cpu[0].Mhz,
		"cores": cpu[0].Cores,
	}
	memoryInfo := map[string]string{
		"total":     strconv.FormatInt(int64(memory.Total/(1024*1024)), 10) + "M",
		"available": strconv.FormatInt(int64(memory.Available/(1024*1024)), 10) + "M",
		"used":      strconv.FormatInt(int64(memory.Used/(1024*1024)), 10) + "M",
		"percent":   strconv.FormatInt(int64(memory.UsedPercent), 10) + "%",
	}
	diskInfo := map[string]string{
		"total":     strconv.FormatInt(int64(disk.Total/(1024*1024)), 10) + "M",
		"available": strconv.FormatInt(int64(disk.Free/(1024*1024)), 10) + "M",
		"used":      strconv.FormatInt(int64(disk.Used/(1024*1024)), 10) + "M",
		"percent":   strconv.FormatInt(int64(disk.UsedPercent), 10) + "%",
	}
	//主机名
	hostName, _ := os.Hostname()
	//系统类型
	sysOs := runtime.GOOS
	//架构信息
	adl := runtime.GOARCH
	//核心数
	core := runtime.GOMAXPROCS(0)
	//go版本
	version := runtime.Version()
	info := Info{
		Name:    hostName,
		Os:      sysOs,
		Adl:     adl,
		CoreNum: core,
		Version: version,
		Cpu:     cpuInfo,
		Memory:  memoryInfo,
		Disk:    diskInfo,
	}
	e := time.Now().Nanosecond()
	fmt.Println("--------------", e-s, "--------------")
	this.Data["json"] = common.ReturnOK(200, "success", info)
	this.ServeJSON()
}
