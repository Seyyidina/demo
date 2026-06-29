package examples.brands;

import com.intuit.karate.junit5.Karate;
public class BrandRunner {
        @Karate.Test
    Karate testUsers() {
        return Karate.run("brands").relativeTo(getClass());
    }
}
