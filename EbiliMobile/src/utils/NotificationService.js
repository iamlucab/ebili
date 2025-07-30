import messaging from '@react-native-firebase/messaging';
import AsyncStorage from '@react-native-async-storage/async-storage';
import api from '../api/api';

class NotificationService {
  constructor() {
    this.messageListener = null;
    this.tokenRefreshListener = null;
  }

  async init() {
    try {
      // Request permission
      const authStatus = await this.requestUserPermission();
      
      if (authStatus) {
        // Get FCM token
        await this.getFcmToken();
        
        // Listen for token refresh
        this.registerTokenRefreshListener();
        
        // Set up message handlers
        this.registerMessageHandlers();
      }
    } catch (error) {
      console.error('Notification service initialization error:', error);
    }
  }

  async requestUserPermission() {
    const authStatus = await messaging().requestPermission();
    const enabled =
      authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
      authStatus === messaging.AuthorizationStatus.PROVISIONAL;
    
    console.log('Authorization status:', authStatus);
    return enabled;
  }

  async getFcmToken() {
    try {
      // Get the device token
      const fcmToken = await messaging().getToken();
      
      if (fcmToken) {
        console.log('FCM Token:', fcmToken);
        
        // Store token locally
        await AsyncStorage.setItem('fcmToken', fcmToken);
        
        // Send token to server
        await this.sendTokenToServer(fcmToken);
      }
    } catch (error) {
      console.error('Error getting FCM token:', error);
    }
  }

  async sendTokenToServer(token) {
    try {
      // Check if user is authenticated
      const userToken = await AsyncStorage.getItem('token');
      
      if (userToken) {
        // Send FCM token to server
        await api.post('/notifications/register-device', { token });
        console.log('FCM token sent to server');
      }
    } catch (error) {
      console.error('Error sending FCM token to server:', error);
    }
  }

  registerTokenRefreshListener() {
    this.tokenRefreshListener = messaging().onTokenRefresh(async (fcmToken) => {
      console.log('FCM Token refreshed:', fcmToken);
      
      // Store new token locally
      await AsyncStorage.setItem('fcmToken', fcmToken);
      
      // Send new token to server
      await this.sendTokenToServer(fcmToken);
    });
  }

  registerMessageHandlers() {
    // Handle foreground messages
    this.messageListener = messaging().onMessage(async (remoteMessage) => {
      console.log('Foreground message received:', remoteMessage);
      
      // You can display a local notification here
      this.displayLocalNotification(remoteMessage);
    });

    // Handle background/quit state messages
    messaging().setBackgroundMessageHandler(async (remoteMessage) => {
      console.log('Background message received:', remoteMessage);
      return Promise.resolve();
    });

    // Handle notification open events
    messaging().onNotificationOpenedApp((remoteMessage) => {
      console.log('Notification opened app:', remoteMessage);
      // Handle navigation based on notification data
      this.handleNotificationNavigation(remoteMessage);
    });

    // Check if app was opened from a notification
    messaging()
      .getInitialNotification()
      .then((remoteMessage) => {
        if (remoteMessage) {
          console.log('App opened from notification:', remoteMessage);
          // Handle navigation based on notification data
          this.handleNotificationNavigation(remoteMessage);
        }
      });
  }

  displayLocalNotification(remoteMessage) {
    // This is where you would display a local notification
    // For React Native, you might use a library like react-native-push-notification
    // or implement platform-specific code
    
    // Example implementation would be:
    // PushNotification.localNotification({
    //   title: remoteMessage.notification.title,
    //   message: remoteMessage.notification.body,
    //   data: remoteMessage.data,
    // });
    
    console.log('Local notification would display:', {
      title: remoteMessage.notification?.title,
      body: remoteMessage.notification?.body,
    });
  }

  handleNotificationNavigation(remoteMessage) {
    // Handle navigation based on notification data
    // This would typically involve using a navigation service or context
    // to navigate to the appropriate screen
    
    if (remoteMessage.data) {
      const { type, id } = remoteMessage.data;
      
      switch (type) {
        case 'order':
          // Navigate to order details
          console.log('Should navigate to order details:', id);
          break;
        case 'loan':
          // Navigate to loan details
          console.log('Should navigate to loan details:', id);
          break;
        case 'payment':
          // Navigate to payment screen
          console.log('Should navigate to payment screen:', id);
          break;
        case 'wallet':
          // Navigate to wallet screen
          console.log('Should navigate to wallet screen');
          break;
        default:
          // Default navigation
          console.log('No specific navigation for notification type:', type);
      }
    }
  }

  cleanup() {
    // Remove listeners when service is no longer needed
    if (this.messageListener) {
      this.messageListener();
      this.messageListener = null;
    }
    
    if (this.tokenRefreshListener) {
      this.tokenRefreshListener();
      this.tokenRefreshListener = null;
    }
  }
}

export default new NotificationService();