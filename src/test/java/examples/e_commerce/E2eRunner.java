package examples.e_commerce;

import com.intuit.karate.junit5.Karate;

public class E2eRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("e_commerce").relativeTo(getClass());
    }
}
