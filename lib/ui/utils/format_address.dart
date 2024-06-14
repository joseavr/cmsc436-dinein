String formatAddressToStateAndCity(String address) {
  final List<String> addressList = address.split(',');

  final String cityAndStateAndZip =
      addressList.sublist(addressList.length - 2).join(', ').toString();

  final zipLength =
      cityAndStateAndZip.split(',')[1].substring(1).split(" ")[2].length;

  final cityAndState = cityAndStateAndZip
      .substring(0, cityAndStateAndZip.length - zipLength)
      .toString();

  return cityAndState;
}
