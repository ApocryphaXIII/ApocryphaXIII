import { Button, ByondUi } from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import {
  CameraConsoleContent,
  prevNextCamera,
  selectCameras,
} from './CameraConsole';

export const NtosSecurEye = (props) => {
  const { act, data, config } = useBackend();
  const { PC_device_theme, mapRef, activeCamera } = data;
  const cameras = selectCameras(data.cameras);
  const [prevCameraName, nextCameraName] = prevNextCamera(
    cameras,
    activeCamera,
  );
  return (
    <NtosWindow width={800} height={600} theme={PC_device_theme}>
      <NtosWindow.Content>
        <div className="CameraConsole__left">
          <CameraConsoleContent />
        </div>
        <div className="CameraConsole__right">
          <div className="CameraConsole__toolbar">
            <b>Camera: </b>
            {(activeCamera && activeCamera.name) || '—'}
          </div>
          <div className="CameraConsole__toolbarRight">
            <Button
              icon="chevron-left"
              disabled={!prevCameraName}
              onClick={() =>
                act('switch_camera', {
                  name: prevCameraName,
                })
              }
            />
            <Button
              icon="chevron-right"
              disabled={!nextCameraName}
              onClick={() =>
                act('switch_camera', {
                  name: nextCameraName,
                })
              }
            />
          </div>
          <ByondUi
            className="CameraConsole__map"
            params={{
              id: mapRef,
              type: 'map',
            }}
          />
        </div>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
