import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.WindowState
import androidx.compose.ui.window.singleWindowApplication
import androidx.compose.runtime.LaunchedEffect

    // companion object {
        // init {
        //     System.loadLibrary("fedimuigo")
        //     System.loadLibrary("fedimuirs_lib")
        // }
    // }


class HelloWorld {
    external fun hello()
    external fun setjvmenv(x: Int)

    companion object  {
        init{
        System.loadLibrary("fedimuigo");
        }
        // val propertyName: String = "Something..."
    }
}

external fun setjvmenv()

fun main() =
    singleWindowApplication(
        title = "Fedim 竹笛 Chat",
        state = WindowState(size = DpSize(500.dp, 800.dp))
    ) {
        //Exception in thread "main" java.lang.UnsatisfiedLinkError: no fedimuigo in java.library.path: $HOME/Library/Java/Extensions:/Library/Java/Extensions:/Network/Library/Java/Extensions:/System/Library/Java/Extensions:/usr/lib/java:.
            // System.loadLibrary("fedimuigo")
            // System.loadLibrary("fedimuirs_lib")
        //setjvmenv()

        LaunchedEffect(Unit) {
            HelloWorld().hello();
            HelloWorld().setjvmenv(123);
        }

        MainView()
        println("run after MainView???")
    }
