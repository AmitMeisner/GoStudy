package com.example.gostudy;

import android.os.Bundle;

import com.google.android.material.bottomnavigation.BottomNavigationView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

public class Main2Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        BottomNavigationView navView = findViewById(R.id.nav_view);
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        System.out.println(0);
        AppBarConfiguration appBarConfiguration = new AppBarConfiguration.Builder(
                R.id.navigation_home, R.id.navigation_stats, R.id.navigation_notifications, R.id.navigation_tips)
                .build();
        System.out.println(1);
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        System.out.println(2);
        NavigationUI.setupActionBarWithNavController(this, navController, appBarConfiguration);
        System.out.println(3);
        NavigationUI.setupWithNavController(navView, navController);
    }

}
