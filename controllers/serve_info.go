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
	Name    string                  `json:"host"`
	Os      string                  `json:"os"`
	Adl     string                  `json:"adl"`
	CoreNum int                     `json:"coreNum"`
	Version string                  `json:"version"`
	Cpu     *map[string]interface{} `json:"cpu"`
	Memory  *map[string]string      `json:"memory"`
	Disk    *[]map[string]string    `json:"disk"`
}

// @router /sys/info [*]
func (this *SysInfo) GetInfo() {
	s := time.Now().Nanosecond()
	cpu, _ := cpu.Info()
	memory, _ := mem.VirtualMemory()
	disks, _ := disk.Partitions(true)
	//disk, _ := disk.Usage("D:")
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
		Cpu:     &cpuInfo,
		Memory:  &memoryInfo,
	}
	if sysOs == "linux" {
		var diskList []map[string]string
		for _, p := range disks {
			if p.Mountpoint == `/` {
				usage, _ := disk.Usage(p.Mountpoint)
				dinfo := map[string]string{
					"name":    p.Mountpoint,
					"total":   fmt.Sprintf("%.2f", float64(usage.Total)/1024/1024/1024) + "G",
					"used":    fmt.Sprintf("%.2f", float64(usage.Used)/1024/1024/1024) + "G",
					"percent": strconv.Itoa(int(usage.UsedPercent)) + "%",
				}
				diskList = append(diskList, dinfo)
			}
		}
		//root, err := disk.Usage("/")
		//fmt.Println("linux", root)
		//if err != nil {
		//	fmt.Println(err, time.Now().Format("2006-01-02 15:04:06"))
		//}
		//dinfo := map[string]string{
		//	"name":    root.Path,
		//	"total":   fmt.Sprintf("%.2f", float64(root.Total)/1024/1024/1024) + "G",
		//	"used":    fmt.Sprintf("%.2f", float64(root.Used)/1024/1024/1024) + "G",
		//	"percent": strconv.Itoa(int(root.UsedPercent)) + "%",
		//}
		//diskList = append(diskList, dinfo)
	} else if sysOs == "windows" {
		var diskList []map[string]string
		for _, p := range disks {
			usage, _ := disk.Usage(p.Mountpoint)
			dinfo := map[string]string{
				"name":    p.Mountpoint,
				"total":   fmt.Sprintf("%.2f", float64(usage.Total)/1024/1024/1024) + "G",
				"used":    fmt.Sprintf("%.2f", float64(usage.Used)/1024/1024/1024) + "G",
				"percent": strconv.Itoa(int(usage.UsedPercent)) + "%",
			}
			diskList = append(diskList, dinfo)
		}
		info.Disk = &diskList
	}
	e := time.Now().Nanosecond()
	fmt.Println("--------------", e-s, "--------------")
	this.Data["json"] = common.ReturnOK(200, "success", info)
	this.ServeJSON()
}
