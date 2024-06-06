import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.LocalTextStyle
import androidx.compose.material.MaterialTheme
import androidx.compose.material.ProvideTextStyle
import androidx.compose.material.Scaffold
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.material.lightColors
import androidx.compose.material.darkColors
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.sp
import chat_mpp.shared.generated.resources.*
import chat_mpp.shared.generated.resources.Res
import chat_mpp.shared.generated.resources.background
// import chat_mpp.shared.generated.resources.backgrounddark
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import org.jetbrains.compose.resources.ExperimentalResourceApi
import org.jetbrains.compose.resources.painterResource

val myUser = User("Me", picture = null)
val friends = listOf(
    User("发Alex", picture = Res.drawable.stock1),
    User("的Casey", picture = Res.drawable.stock2),
    User("上Sam", picture = Res.drawable.stock3)
)
val friendMessages = listOf(
    "How's everybody 大概 doing today?",
    "I've been meaning 会火 to chat!",
    "When 二哥 do we hang out next? 😋",
    "We really need 初始化 to catch up!",
    "It's been too long! 宽度",
    "I can't\nbelieve\nit! 😱",
    "Did you see that 欧文 ludicrous\ndisplay last night?",
    "We 消费额 should meet up in person!",
    "How about a农副业 round of pinball?",
    "I'd love  烟消云散to:\n🍔 Eat something\n🎥 Watch a movie, maybe?\nWDYT?",
    "what about html <a href=\"\">jhhhe </a> pin"
)
val store = CoroutineScope(SupervisorJob()).createStore()

@Composable
fun ChatAppWithScaffold(displayTextField: Boolean = true) {
    Theme {
        Scaffold(
            topBar = {
                TopAppBar(
                    title = { Text("The Composers Chat 演示") },
                    backgroundColor = MaterialTheme.colors.background,
                )
            }) {
            ChatApp(displayTextField = displayTextField)
        }
    }
}

@OptIn(ExperimentalResourceApi::class)
@Composable
fun ChatApp(displayTextField: Boolean = true) {
    val state by store.stateFlow.collectAsState()
    Theme {
        Surface {
            Box(modifier = Modifier.fillMaxSize()) {
                Image(painterResource(Res.drawable.bg123), null, contentScale = ContentScale.Crop)
                Column(
                    modifier = Modifier.fillMaxSize()
                ) {
                    Box(Modifier.weight(1f)) {
                        Messages(state.messages)
                    }
                    if (displayTextField) {
                        SendMessage { text ->
                            store.send(
                                Action.SendMessage(
                                    Message(myUser, text)
                                )
                            )
                        }
                    }
                }
            }
        }
    }
    LaunchedEffect(Unit) {
        var lastFriend = friends.random()
        var lastMessage = friendMessages.random()
        while (true) {
            val thisFriend = friends.random()
            val thisMessage = friendMessages.random()
            if(thisFriend == lastFriend) continue
            if(thisMessage == lastMessage) continue
            lastFriend = thisFriend
            lastMessage = thisMessage
            println("hello $thisFriend, $thisMessage")
            store.send(
                Action.SendMessage(
                    message = Message(
                        user = thisFriend,
                        text = thisMessage
                    )
                )
            )
            delay(5000)
        }
    }
}

@Composable
fun Theme(content: @Composable () -> Unit) {
    MaterialTheme(
        colors = darkColors(
            surface = Color(ChatColorsDark.SURFACE),
            background = Color(ChatColorsDark.TOP_GRADIENT.last()),
        ),
    ) {
        ProvideTextStyle(LocalTextStyle.current.copy(letterSpacing = 0.sp)) {
            content()
        }
    }
}
@Composable
fun Themebak(content: @Composable () -> Unit) {
    MaterialTheme(
        colors = lightColors(
            surface = Color(ChatColors.SURFACE),
            background = Color(ChatColors.TOP_GRADIENT.last()),
        ),
    ) {
        ProvideTextStyle(LocalTextStyle.current.copy(letterSpacing = 0.sp)) {
            content()
        }
    }
}
