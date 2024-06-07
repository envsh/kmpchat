package main

import (
	"fmt"
	"log"
	"runtime"

	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
	_ "github.com/kitech/gopp/cgopp"
)

/*
#include <stdio.h>

*/
import "C"

func main() {
	mainrealentry()
}

// dont block this func
// this is real so/dylib entry
func init() {
	if runtime.GOOS == "android" {

	}
	// 所有系统都要以so的形式加载，自己创建jvm失败
	go mainrealentry()
}

func mainrealentry() {
	if false {
		runtime.LockOSThread()
		var args2 = packjvmargs()
		rv := cgopp.JavaExe("MainKt", "main", args2...)
		log.Println("JavaExec", rv)
	}
	if false {
		cgopp.JniFindClass("Ljava/lang/String")
	}
	for {
		log.Println("runin mainentry", cgopp.JNIIsLoad(), cgopp.MyTid(), gopp.TimeToFmt1Now())
		gopp.SleepMs(2234)
		if cgopp.JNIIsLoad() {
			testjni()
		}
	}
	// gopp.Forever()
}

//export Java_HelloWorld_hello
func Java_HelloWorld_hello(env voidptr, x voidptr, arg0 uintptr) int {
	var jenv = cgopp.JNIEnv(env)
	log.Println("hello 世界!!!111", jenv.Toptr(), x, arg0)
	return 1
}

// not used, obtain jvmenv other way

//export Java_HelloWorld_setjvmenv
func Java_HelloWorld_setjvmenv(env voidptr, x voidptr, arg0 uintptr) {
	log.Println("hello 世界!!!222", env, x, arg0)

}

func testjni() {
	err := cgopp.RunOnJVM(func(vm, env, ctx uintptr) error {
		var r any
		if false {
			clsobj := cgopp.Jenv.FindClass("java/lang/String")
			log.Println(clsobj)
			return fmt.Errorf("hehehhe %v", clsobj)
		}
		if true {
			x := cgopp.Jenv.NewStrUTF("hhahhaa")
			// log.Println(x)
			r = x
		}
		return fmt.Errorf("%v", r)
	})
	gopp.ErrPrint(err)
}
