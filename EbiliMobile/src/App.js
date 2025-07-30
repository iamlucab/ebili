import React, { useEffect } from 'react';
import { StatusBar, SafeAreaView, StyleSheet } from 'react-native';
import { Provider as PaperProvider } from 'react-native-paper';
import { NavigationContainer } from '@react-navigation/native';
import { AuthProvider } from './context/AuthContext';
import AppNavigator from './navigation/AppNavigator';
import NotificationService from './utils/NotificationService';

const App = () => {
  // Initialize notification service
  useEffect(() => {
    const initNotifications = async () => {
      await NotificationService.init();
    };
    
    initNotifications();
    
    // Cleanup notification listeners when component unmounts
    return () => {
      NotificationService.cleanup();
    };
  }, []);

  return (
    <AuthProvider>
      <PaperProvider>
        <NavigationContainer>
          <SafeAreaView style={styles.container}>
            <StatusBar barStyle="dark-content" backgroundColor="#ffffff" />
            <AppNavigator />
          </SafeAreaView>
        </NavigationContainer>
      </PaperProvider>
    </AuthProvider>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
});

export default App;